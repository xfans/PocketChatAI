import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pocket_chat/src/models/message.dart';
import 'package:pocket_chat/src/repositories/chat_repository.dart';
import 'package:pocket_chat/src/models/session.dart';

import '../repositories/provider_repository.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  final ChatRepository _repository;
  final _repo = ProviderRepository.instance;
  ChatCubit(this._repository) : super(ChatInitial());

  /// Load messages from the database
  void loadMessages() {
    emit(ChatLoading());
    _repository.getMessages().listen((messages) {
      emit(ChatLoaded(messages));
    });
  }

  void loadSessions() {
    emit(ChatLoading());
    _repository.getSessions().listen((sessions) {
      print("loadSessions:${sessions.length}");
      emit(ChatSessionsLoaded(sessions));
    });
  }

  Future<int> newSession(String content) {
      final session = Session(
        name: content,
        model: 'gpt-3.5-turbo',
        temperature: 0.7,
        maxTokens: 1000,
      );

      print("newSession");
    return _repository.addSession(session);
  }

  /// Send a message
  Future<void> sendMessage(String message,int sessionId,{bool isWebSearch = false}) async {
    if (message.trim().isEmpty) return;

    try {
      emit(ChatLoading());
      var provider = await _repo.getDefault();
      print("getDefault:$provider");
      if(provider != null){
        await _repository.sendMessage(provider,message,sessionId,isWebSearch: isWebSearch);
      }

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
