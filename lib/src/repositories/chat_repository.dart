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
    msg.contentParts = message;
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

      // Collect streaming response and tool calls
      String assistantContent = '';
      final toolCallsMap = <int, Map<String, dynamic>>{};

      await for (final chunk in aiResponse) {
        final delta = chunk.choices?.first.delta;

        // Handle content
        final content = delta?.content;
        if (content != null && content.isNotEmpty) {
          print(assistantContent);
          assistantContent += content;
          modifyMessage(sessionId, messageId, assistantContent, saveDb: false);
        }

        // Handle tool calls
        final toolCalls = delta?.toolCalls;
        if (toolCalls != null) {
          for (final toolCall in toolCalls) {
            final index = toolCall.index ?? -1;
            if (index != -1) {
              final id = toolCall.id ?? '';
                toolCallsMap[index] ??= {
                  'id': id,
                  'type': 'function',
                  'function': {'name': '', 'arguments': ''},
                };
              if (toolCall.function?.name != null) {
                toolCallsMap[index]!['function']['name'] = toolCall.function!.name;
              }
              if (toolCall.function?.arguments != null) {
                toolCallsMap[index]!['function']['arguments'] +=
                    toolCall.function!.arguments;
              }
            }
          }
        }
      }
      // print("aiResponse:${aiResponse.choices.first.message.content}");
      // print("aiResponse:${aiResponse.choices.first.message.toolCalls}");
      // var toolCalls = aiResponse.choices.first.message.toolCalls;
      if (toolCallsMap.isNotEmpty) {
        final toolCalls = toolCallsMap.values
            .map(
              (toolCallData) => ChatCompletionMessageToolCall(
                id: toolCallData['id'],
                type: ChatCompletionMessageToolCallType.function,
                function: ChatCompletionMessageFunctionCall(
                  name: toolCallData['function']['name'],
                  arguments: toolCallData['function']['arguments'],
                ),
              ),
            )
            .toList();

        for (var toolCall in toolCalls) {
          final functionCall = toolCall.function;
          final arguments =
              json.decode(functionCall.arguments) as Map<String, dynamic>;
          final functionResult = await MCPManager.instance.execute(
            functionCall.name,
            arguments,
          );
          print("-----tool Call 3-----:${json.encode(functionResult)}");
          print("toolCallResponse:${json.encode(functionResult)}");
          list.add(
            ChatCompletionMessage.tool(
              toolCallId: toolCall.id,
              content: json.encode(functionResult),
            ),
          );
          assistantContent += json.encode(functionResult);
          modifyMessage(
            sessionId,
            messageId,
            assistantContent,
            saveDb: true,
          );
        }

        var aiResponse = OpenAiCompatible(
          provider,
        ).completion(list, tools: mcpTools);

        await for (final chunk in aiResponse) {
          final delta = chunk.choices?.first.delta;

          // Handle content
          final content = delta?.content;
          if (content != null) {
            assistantContent += content;
            modifyMessage(sessionId, messageId, assistantContent, saveDb: false);
          }
        }
      }
      modifyMessage(
        sessionId,
        messageId,
        assistantContent ?? 'No response from AI',
        saveDb: true,
      );
    } catch (e) {
      modifyMessage(sessionId, messageId, 'Sorry, I encountered an error: $e');
    }
  }
}
