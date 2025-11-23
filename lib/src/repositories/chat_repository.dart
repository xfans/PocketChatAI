import 'dart:async';
import 'dart:convert';

import 'package:openai_dart/openai_dart.dart';
import 'package:pocket_chat/src/mcp/mcp_manager.dart';
import 'package:pocket_chat/src/models/message.dart';
import 'package:pocket_chat/src/models/session.dart';
import 'package:pocket_chat/src/models/model_provider.dart';
import 'package:pocket_chat/src/database/objectbox_service.dart';
import 'package:pocket_chat/src/services/open_ai_compatible.dart';
import 'package:pocket_chat/src/mcp/web_search.dart';

class ChatRepository {
  final ObjectBoxService _database;
  final Map<int, List<Message>> _messagesMap = {};
  final Map<int, StreamController<List<Message>>> _streamControllers = {};

  ChatRepository(this._database);

  Stream<List<Message>> getMessagesBySessionIdOnce(int sessionId) {
    if (_streamControllers[sessionId] == null) {
      _streamControllers[sessionId] = StreamController<List<Message>>.broadcast(
        onCancel: () {
          _streamControllers.remove(sessionId);
          _messagesMap.remove(sessionId);
        },
      );
    }
    _database.getMessagesBySessionId(sessionId).then((messages) {
      _messagesMap[sessionId] = messages;
      _streamControllers[sessionId]!.add(List.unmodifiable(messages));
    });
    return _streamControllers[sessionId]!.stream;
  }

  Future<int> addMessage(int sessionId, Message message) async {
    print("addMessage:$message");
    var id = await _database.addMessage(message);
    message.id = id;
    var list = _messagesMap[sessionId] ??= [];
    list.add(message);
    _streamControllers[sessionId]!.add(List.unmodifiable(list));
    return id;
  }

  Future<int> modifyMessage(
    int sessionId,
    int messageId,
    String message, {
    bool saveDb = false,
  }) async {
    print("modifyMessage:$message");

    var list = _messagesMap[sessionId] ??= [];
    var msg = list.firstWhere((element) {
      return element.id == messageId;
    });
    msg.id = messageId;
    var content = msg.contentParts;
    msg.contentParts = content + message;
    if (saveDb) {
      _database.modifyMessage(msg);
    }
    _streamControllers[sessionId]!.add(List.unmodifiable(list));
    return messageId;
  }

  Stream<List<Session>> getSessions() {
    print("getSessions");
    return _database.getAllSessionsStream();
  }

  Future<int> addSession(Session session) {
    print("addSession:$session");
    return _database.addSession(session);
  }

  /// Send a user message and save both the user message and AI response
  Future<void> sendMessage(
    ModelProvider provider,
    String content,
    int sessionId, {
    bool isWebSearch = false,
  }) async {
    print("sendMessage:$content");
    // Create a default session if it doesn't exist

    // Save user message with session ID
    final userMessage = Message.user(content: content, sessionId: sessionId);
    addMessage(sessionId, userMessage);
    final assistantMessage = Message.ai(content: "", sessionId: sessionId);
    var messageId = await addMessage(sessionId, assistantMessage);
    List<ChatCompletionMessage> list = [];
    list.add(
      ChatCompletionMessage.user(
        content: ChatCompletionUserMessageContent.string(content),
      ),
    );
    try {
      print("provider:$provider");
      var mcpTools = MCPManager.instance.tools();
      print("mcpTools:${mcpTools.toString()}");
      var aiResponse = await OpenAiCompatible(
        provider,
      ).completion(list, tools: mcpTools);
      print("aiResponse:${aiResponse.choices.first.message.content}");
      print("aiResponse:${aiResponse.choices.first.message.toolCalls}");
      var toolCalls = aiResponse.choices.first.message.toolCalls;
      if (toolCalls != null && toolCalls.isNotEmpty) {
        for (var toolCall in toolCalls) {
          final functionCall = toolCall.function;
          final arguments =
              json.decode(functionCall.arguments) as Map<String, dynamic>;
          final functionResult = await MCPManager.instance.execute(
            functionCall.name,
            arguments,
          );
          print("toolCallResponse:${json.encode(functionResult)}");
          list.add(
            ChatCompletionMessage.tool(
              toolCallId: toolCall.id,
              content: json.encode(functionResult),
            ),
          );
          modifyMessage(
            sessionId,
            messageId,
            json.encode(functionResult),
            saveDb: true,
          );
        }

        aiResponse = await OpenAiCompatible(
          provider,
        ).completion(list, tools: mcpTools);
        print("aiResponse2:${aiResponse.choices.first.message.content}");
      }
      modifyMessage(
        sessionId,
        messageId,
        aiResponse.choices.first.message.content ?? 'No response from AI',
        saveDb: true,
      );
    } catch (e) {
      modifyMessage(sessionId, messageId, 'Sorry, I encountered an error: $e');
    }
  }

}
