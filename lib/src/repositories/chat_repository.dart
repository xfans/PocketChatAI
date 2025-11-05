import 'package:pocket_chat/src/models/message.dart';
import 'package:pocket_chat/src/database/objectbox_service.dart';
import 'package:pocket_chat/src/services/ai_service.dart';

class ChatRepository {
  final ObjectBoxService _database;
  final AIService _aiService;

  ChatRepository(this._database, this._aiService);

  /// Get all messages as a stream
  Stream<List<Message>> getMessages() {
    return _database.getAllMessagesStream();
  }

  /// Send a user message and save both the user message and AI response
  Future<void> sendMessage(String content) async {
    // Save user message
    final userMessage = Message(
      content: content,
      isUserMessage: true,
    );
    await _database.addMessage(userMessage);

    try {
      // Get AI response
      final aiResponse = await _aiService.sendMessage(content);

      // Save AI message
      final aiMessage = Message(
        content: aiResponse,
        isUserMessage: false,
      );
      await _database.addMessage(aiMessage);
    } catch (e) {
      // Save error message
      final errorMessage = Message(
        content: 'Sorry, I encountered an error: $e',
        isUserMessage: false,
      );
      await _database.addMessage(errorMessage);
    }
  }

  /// Clear all messages
  Future<void> clearMessages() async {
    await _database.clearAllMessages();
  }
}
