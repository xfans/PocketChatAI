import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pocket_chat/src/models/message.dart';
import 'package:pocket_chat/src/repositories/chat_repository.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  final ChatRepository _repository;

  ChatCubit(this._repository) : super(ChatInitial());

  /// Load messages from the database
  void loadMessages() {
    emit(ChatLoading());
    _repository.getMessages().listen((messages) {
      emit(ChatLoaded(messages));
    });
  }

  /// Send a message
  Future<void> sendMessage(String message) async {
    if (message.trim().isEmpty) return;

    try {
      emit(ChatLoading());
      await _repository.sendMessage(message);
    } catch (e) {
      emit(ChatError('Failed to send message: $e'));
    }
  }

  /// Clear all messages
  Future<void> clearMessages() async {
    try {
      await _repository.clearMessages();
      emit(ChatLoaded([]));
    } catch (e) {
      emit(ChatError('Failed to clear messages: $e'));
    }
  }
}
