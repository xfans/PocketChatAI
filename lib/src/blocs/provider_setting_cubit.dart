import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:openai_dart/openai_dart.dart';
import 'package:pocket_chat/src/blocs/provider_setting_state.dart';
import 'package:pocket_chat/src/services/open_ai_compatible.dart';

import '../repositories/provider_repository.dart';

class ProviderSettingCubit extends Cubit<ProviderSettingState> {
  ProviderSettingCubit() : super(const ProviderSettingState());

  final _repo = ProviderRepository.instance;

  /* ---------- 业务意图 ---------- */

  Future<void> loadList() async {
    try {
      emit(state.copyWith(providers: await _repo.loadAll()));
    } catch (_) {
      emit(state.copyWith(providers: null));
    }
  }

  Future<void> loadSingle(String id) async {
    try {
      final p = await _repo.get(id);
      emit(state.copyWith(provider: p?.id.isEmpty == true ? null : p));
    } catch (_) {
      emit(state.copyWith(provider: null));
    }
  }

  Future<void> save(String id, {String? apiKey, String? apiHost}) async {
    await _repo.save(id, apiKey: apiKey, apiHost: apiHost);
    // 保存完再拿一份最新数据刷新界面
    await loadSingle(id);
  }

  /* ---------- 伪校验 ---------- */
  Future<void> checkApiKey(String id, String key) async {
    emit(state.copyWith(isCheckingApiKey: true));
    try {
      if(state.provider != null){
        var provider = state.provider!.copyWith(apiKey: key);
        var res = await OpenAiCompatible(provider).completion('test');
        print('res:$res');
      }

      await save(id, apiKey: key);
      emit(state.copyWith(isCheckingApiKey: false, isApiKeyValid: true));
    } catch (e) {
      print('catch:$e');
      emit(state.copyWith(isCheckingApiKey: false, isApiKeyValid: false));
      return;
    }

  }
}