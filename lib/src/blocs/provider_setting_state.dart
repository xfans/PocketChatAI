part of 'provider_setting_cubit.dart';

class ProviderSettingLoaded {
  final ModelProvider? provider;
  final List<ModelProvider>? providers;
  final bool isApiKeyValid ;
  final bool isCheckingApiKey;

  ProviderSettingLoaded(
      {this.isApiKeyValid = false,
      this.isCheckingApiKey = false,
      this.provider,
      this.providers});
}
