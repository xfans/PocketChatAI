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

  ChatRepository(this._database);

  /// Get all messages as a stream
  Stream<List<Message>> getMessages() {
    return _database.getAllMessagesStream();
  }

  /// Send a user message and save both the user message and AI response
  Future<void> sendMessage(
    ModelProvider provider,
    String content, {
    bool isWebSearch = false,
  }) async {
    // Create a default session if it doesn't exist
    final session = Session(
      id: 1, // Default session ID
      name: 'Default Session',
      model: 'gpt-3.5-turbo',
      temperature: 0.7,
      maxTokens: 1000,
    );

    // Save the session
    await _database.addSession(session);

    // Save user message with session ID
    final userMessage = Message.user(content: content, sessionId: session.id);
    await _database.addMessage(userMessage);
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
          final toolsMessage = Message.ai(
            content: json.encode(functionResult),
            sessionId: session.id,
          );
          await _database.addMessage(toolsMessage);
        }

        aiResponse = await OpenAiCompatible(
          provider,
        ).completion(list, tools: mcpTools);
        print("aiResponse2:${aiResponse.choices.first.message.content}");
      }
      final aiMessage = Message.ai(
        content:
            aiResponse.choices.first.message.content ?? 'No response from AI',
        sessionId: session.id,
      );
      await _database.addMessage(aiMessage);
    } catch (e) {
      // Save error message with session ID
      final errorMessage = Message.system(
        content: 'Sorry, I encountered an error: $e',
        sessionId: session.id,
      );
      await _database.addMessage(errorMessage);
    }
  }

  /// Clear all messages
  Future<void> clearMessages() async {
    await _database.clearAllMessages();
  }
}
