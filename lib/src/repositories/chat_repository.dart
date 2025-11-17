import 'package:pocket_chat/src/models/message.dart';
import 'package:pocket_chat/src/models/session.dart';
import 'package:pocket_chat/src/models/model_provider.dart';
import 'package:pocket_chat/src/database/objectbox_service.dart';
import 'package:pocket_chat/src/services/open_ai_compatible.dart';

class ChatRepository {
  final ObjectBoxService _database;

  ChatRepository(this._database);

  /// Get all messages as a stream
  Stream<List<Message>> getMessages() {
    return _database.getAllMessagesStream();
  }

  /// Send a user message and save both the user message and AI response
  Future<void> sendMessage(ModelProvider provider,String content) async {
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

    try {
      print("provider:$provider");
      var aiResponse = await OpenAiCompatible(provider).completion(content);
      // Save AI message with session ID
      final aiMessage = Message.ai(
        content: aiResponse ?? 'No response from AI',
        sessionId: session.id
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