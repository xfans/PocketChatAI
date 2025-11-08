import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pocket_chat/src/ui/widgets/custom_app_bar.dart';
import 'package:pocket_chat/src/services/provider_service.dart';
import 'package:pocket_chat/src/models/model_provider.dart';

import '../../blocs/provider_setting_cubit.dart';

class ModelProvidersScreen extends StatefulWidget {
  const ModelProvidersScreen({super.key});

  @override
  State<ModelProvidersScreen> createState() => _ModelProvidersScreenState();
}

class _ModelProvidersScreenState extends State<ModelProvidersScreen> {
  @override
  void initState() {
    super.initState();
    context.read<ProviderSettingCubit>().loadProviderList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Model Provider',
        onBackPressed: () {
          context.pop();
        },
      ),
      body: BlocBuilder<ProviderSettingCubit, ProviderSettingLoaded>(
          builder: (context, state) {
        return ListView.builder(
          itemCount: state.providers?.length ?? 0,
          itemBuilder: (context, index) {
            final provider = state.providers?[index];
            if (provider == null) return Container();
            return ListTile(
              leading: _buildProviderIcon(provider.id),
              title: Text(provider.name),
              // subtitle: Text(provider.type),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                context.pushNamed('modelSettings', pathParameters: {
                  'providerId': provider.id,
                });
              },
            );
          },
        );
      }),
    );
  }

  Widget _buildProviderIcon(String providerId) {
    // Map provider IDs to their corresponding image assets
    final imageMap = {
      'openai': 'images/providers/openai.png',
      'claude': 'images/providers/claude.png',
      'gemini': 'images/providers/gemini.png',
      'ollama': 'images/providers/ollama.png',
      'lmstudio': 'images/providers/lm-studio.png',
      'deepseek': 'images/providers/deepseek.png',
      'siliconflow': 'images/providers/siliconflow.png',
      'openrouter': 'images/providers/openrouter.png',
      'volcengine': 'images/providers/volcengine.png',
      'azure': 'images/providers/azure.png',
      'xai': 'images/providers/xAI.png',
      'mistralai': 'images/providers/mistral-ai.png',
      'perplexity': 'images/providers/perplexity.png',
      'groq': 'images/providers/groq.png',
      'chatglm6b': 'images/providers/chatglm-6b.png',
    };

    final imagePath = imageMap[providerId];

    if (imagePath != null) {
      return Image.asset(
        imagePath,
        width: 24,
        height: 24,
        fit: BoxFit.contain,
      );
    }

    // Fallback to the cloud icon if no image is found
    return const Icon(Icons.cloud);
  }
}
