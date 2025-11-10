
import 'package:freezed_annotation/freezed_annotation.dart';

import '../models/model_provider.dart';
part 'provider_setting_state.freezed.dart';


@freezed
abstract class ProviderSettingState with _$ProviderSettingLoaded {
  const factory ProviderSettingState({
    ModelProvider? provider,
    List<ModelProvider>? providers,
     bool? isApiKeyValid,
     bool? isCheckingApiKey,
  }) = _ProviderSettingLoaded;
}
