import 'package:pocket_chat/src/models/model_provider.dart';

class ProviderService {
  static final ProviderService _instance = ProviderService._internal();
  factory ProviderService() => _instance;
  ProviderService._internal();

  List<ModelProvider> _providers = [];
  bool _isLoaded = false;

  List<ModelProvider> get providers => _providers;

  Future<void> loadProviders() async {
    if (_isLoaded) return;

    try {
      _providers = getDefaultProviders();
      _isLoaded = true;
    } catch (e) {
      print('Error loading providers: $e');
    }
  }

  ModelProvider? getProviderById(String id) {
    try {
      return _providers.firstWhere((provider) => provider.id == id);
    } catch (e) {
      return null;
    }
  }

  static List<ModelProvider> getDefaultProviders() {
    return [
      ModelProvider(
        id: 'openai',
        name: 'OpenAI',
        type: 'OpenAI',
        website: 'https://openai.com',
        apiHost: 'https://api.openai.com',
        models: [
          ModelInfo(
            modelId: 'gpt-5-chat-latest',
            capabilities: ['vision', 'tool_use'],
            contextWindow: 400000,
            maxOutput: 128000,
          ),
          ModelInfo(
            modelId: 'gpt-5',
            capabilities: ['vision', 'tool_use'],
            contextWindow: 400000,
            maxOutput: 128000,
          ),
          ModelInfo(
            modelId: 'gpt-5-mini',
            capabilities: ['vision', 'tool_use'],
            contextWindow: 128000,
            maxOutput: 4096,
          ),
          ModelInfo(
            modelId: 'gpt-5-nano',
            capabilities: ['vision', 'tool_use'],
            contextWindow: 128000,
            maxOutput: 4096,
          ),
          ModelInfo(
            modelId: 'gpt-4o',
            capabilities: ['vision', 'tool_use'],
            contextWindow: 128000,
            maxOutput: 4096,
          ),
          ModelInfo(
            modelId: 'gpt-4o-mini',
            capabilities: ['vision', 'tool_use'],
            contextWindow: 128000,
            maxOutput: 4096,
          ),
          ModelInfo(
            modelId: 'o4-mini',
            capabilities: ['vision', 'tool_use', 'reasoning'],
            contextWindow: 200000,
            maxOutput: 100000,
          ),
          ModelInfo(
            modelId: 'o3-mini',
            capabilities: ['vision', 'tool_use', 'reasoning'],
            contextWindow: 200000,
            maxOutput: 200000,
          ),
          ModelInfo(
            modelId: 'o3',
            capabilities: ['vision', 'tool_use', 'reasoning'],
            contextWindow: 200000,
            maxOutput: 100000,
          ),
          ModelInfo(
            modelId: 'text-embedding-3-small',
            type: 'embedding',
            capabilities: [],
            contextWindow: null,
            maxOutput: null,
          ),
        ],
      ),
      ModelProvider(
        id: 'claude',
        name: 'Claude',
        type: 'Claude',
        website: 'https://www.anthropic.com',
        apiHost: 'https://api.anthropic.com/v1',
        models: [
          ModelInfo(
            modelId: 'claude-opus-4-0',
            contextWindow: 200000,
            maxOutput: 32000,
            capabilities: ['vision', 'reasoning', 'tool_use'],
          ),
          ModelInfo(
            modelId: 'claude-sonnet-4-0',
            contextWindow: 200000,
            maxOutput: 64000,
            capabilities: ['vision', 'reasoning', 'tool_use'],
          ),
          ModelInfo(
            modelId: 'claude-3-7-sonnet-latest',
            capabilities: ['vision', 'tool_use', 'reasoning'],
            contextWindow: 200000,
            maxOutput: null,
          ),
          ModelInfo(
            modelId: 'claude-3-5-sonnet-latest',
            capabilities: ['vision'],
            contextWindow: 200000,
            maxOutput: null,
          ),
          ModelInfo(
            modelId: 'claude-3-5-haiku-latest',
            capabilities: ['vision'],
            contextWindow: 200000,
            maxOutput: null,
          ),
          ModelInfo(
            modelId: 'claude-3-opus-latest',
            capabilities: ['vision'],
            contextWindow: 200000,
            maxOutput: null,
          ),
        ],
      ),
      ModelProvider(
        id: 'gemini',
        name: 'Gemini',
        type: 'Gemini',
        website: 'https://gemini.google.com/',
        apiHost: 'https://generativelanguage.googleapis.com',
        models: [
          ModelInfo(
            modelId: 'gemini-2.5-flash',
            capabilities: ['vision', 'reasoning', 'tool_use'],
            contextWindow: 1000000,
            maxOutput: 8192,
          ),
          ModelInfo(
            modelId: 'gemini-2.5-pro',
            capabilities: ['vision', 'reasoning', 'tool_use'],
            contextWindow: 1000000,
            maxOutput: 8192,
          ),
          ModelInfo(
            modelId: 'gemini-2.5-flash-image-preview',
            capabilities: ['vision'],
            contextWindow: 32768,
            maxOutput: 8192,
          ),
          ModelInfo(
            modelId: 'gemini-2.0-flash-exp',
            capabilities: ['vision'],
            contextWindow: 1000000,
            maxOutput: 8192,
          ),
          ModelInfo(
            modelId: 'gemini-2.0-flash-thinking-exp',
            capabilities: ['vision', 'reasoning'],
            contextWindow: 32000,
            maxOutput: 8000,
          ),
          ModelInfo(
            modelId: 'gemini-2.0-flash-thinking-exp-1219',
            capabilities: ['vision', 'reasoning'],
            contextWindow: 32000,
            maxOutput: 8000,
          ),
          ModelInfo(
            modelId: 'gemini-1.5-pro-latest',
            capabilities: ['vision'],
            contextWindow: 2000000,
            maxOutput: 8192,
          ),
          ModelInfo(
            modelId: 'gemini-1.5-flash-latest',
            capabilities: ['vision'],
            contextWindow: 1000000,
            maxOutput: 8192,
          ),
        ],
      ),
      ModelProvider(
        id: 'ollama',
        name: 'Ollama',
        type: 'OpenAI',
        apiHost: 'http://127.0.0.1:11434',
        models: [],
      ),
      ModelProvider(
        id: 'lmstudio',
        name: 'LM Studio',
        type: 'OpenAI',
        apiHost: 'http://127.0.0.1:1234',
        models: [],
      ),
      ModelProvider(
        id: 'deepseek',
        name: 'DeepSeek',
        type: 'OpenAI',
        website: 'https://www.deepseek.com/',
        models: [
          ModelInfo(
            modelId: 'deepseek-chat',
            contextWindow: 64000,
            capabilities: ['tool_use'],
            maxOutput: null,
          ),
          ModelInfo(
            modelId: 'deepseek-coder',
            contextWindow: 64000,
            capabilities: [],
            maxOutput: null,
          ),
          ModelInfo(
            modelId: 'deepseek-reasoner',
            contextWindow: 64000,
            capabilities: ['reasoning', 'tool_use'],
            maxOutput: null,
          ),
        ],
      ),
      ModelProvider(
        id: 'siliconflow',
        name: 'SiliconFlow',
        type: 'OpenAI',
        website: 'https://siliconflow.cn/',
        apiHost: 'https://api.siliconflow.cn',
        models: [
          ModelInfo(
            modelId: 'deepseek-ai/DeepSeek-V3.1',
            capabilities: ['tool_use'],
            contextWindow: 160000,
            maxOutput: null,
          ),
          ModelInfo(
            modelId: 'deepseek-ai/DeepSeek-V3',
            capabilities: ['tool_use'],
            contextWindow: 64000,
            maxOutput: null,
          ),
          ModelInfo(
            modelId: 'deepseek-ai/DeepSeek-R1',
            capabilities: ['reasoning', 'tool_use'],
            contextWindow: 64000,
            maxOutput: null,
          ),
          ModelInfo(
            modelId: 'Pro/deepseek-ai/DeepSeek-R1',
            capabilities: ['reasoning', 'tool_use'],
            contextWindow: 64000,
            maxOutput: null,
          ),
          ModelInfo(
            modelId: 'Pro/deepseek-ai/DeepSeek-V3',
            capabilities: ['tool_use'],
            contextWindow: 64000,
            maxOutput: null,
          ),
          ModelInfo(
            modelId: 'Pro/deepseek-ai/DeepSeek-V3.1',
            capabilities: ['tool_use'],
            contextWindow: 160000,
            maxOutput: null,
          ),
          ModelInfo(
            modelId: 'moonshotai/Kimi-K2-Instruct-0905',
            capabilities: ['tool_use'],
            contextWindow: 256000,
            maxOutput: null,
          ),
          ModelInfo(
            modelId: 'Qwen/Qwen2.5-7B-Instruct',
            capabilities: ['tool_use'],
            contextWindow: 32000,
            maxOutput: null,
          ),
          ModelInfo(
            modelId: 'Qwen/Qwen2.5-14B-Instruct',
            capabilities: ['tool_use'],
            contextWindow: 32000,
            maxOutput: null,
          ),
          ModelInfo(
            modelId: 'Qwen/Qwen2.5-32B-Instruct',
            capabilities: ['tool_use'],
            contextWindow: 32000,
            maxOutput: null,
          ),
          ModelInfo(
            modelId: 'Qwen/Qwen2.5-72B-Instruct',
            capabilities: ['tool_use'],
            contextWindow: 32000,
            maxOutput: null,
          ),
          ModelInfo(
            modelId: 'Qwen/Qwen2.5-VL-32B-Instruct',
            capabilities: ['vision'],
            contextWindow: 128000,
            maxOutput: null,
          ),
          ModelInfo(
            modelId: 'Qwen/Qwen2.5-VL-72B-Instruct',
            capabilities: ['vision'],
            contextWindow: 128000,
            maxOutput: null,
          ),
          ModelInfo(
            modelId: 'Qwen/QVQ-72B-Preview',
            capabilities: ['vision'],
            contextWindow: 128000,
            maxOutput: null,
          ),
          ModelInfo(
            modelId: 'Qwen/QwQ-32B',
            capabilities: ['tool_use'],
            contextWindow: 32000,
            maxOutput: null,
          ),
          ModelInfo(
            modelId: 'Pro/Qwen/Qwen2.5-VL-7B-Instruct',
            capabilities: ['vision'],
            contextWindow: 32000,
            maxOutput: null,
          ),
          ModelInfo(
            modelId: 'BAAI/bge-m3',
            type: 'embedding',
            capabilities: [],
            contextWindow: null,
            maxOutput: null,
          ),
          ModelInfo(
            modelId: 'BAAI/bge-large-zh-v1.5',
            type: 'embedding',
            capabilities: [],
            contextWindow: null,
            maxOutput: null,
          ),
          ModelInfo(
            modelId: 'Pro/BAAI/bge-m3',
            type: 'embedding',
            capabilities: [],
            contextWindow: null,
            maxOutput: null,
          ),
          ModelInfo(
            modelId: 'BAAI/bge-reranker-v2-m3',
            type: 'rerank',
            capabilities: [],
            contextWindow: null,
            maxOutput: null,
          ),
        ],
      ),
      ModelProvider(
        id: 'openrouter',
        name: 'OpenRouter',
        type: 'OpenAI',
        website: 'https://openrouter.ai/',
        apiHost: 'https://openrouter.ai/api/v1',
        models: [
          ModelInfo(
            modelId: 'deepseek/deepseek-chat-v3.1:free',
            type: 'chat',
            nickname: 'DeepSeek: DeepSeek V3.1 (free)',
            capabilities: ['tool_use'],
            contextWindow: 64000,
            maxOutput: null,
          ),
          ModelInfo(
            modelId: 'deepseek/deepseek-chat-v3-0324:free',
            type: 'chat',
            nickname: 'DeepSeek: DeepSeek V3 0324 (free)',
            capabilities: ['tool_use'],
            contextWindow: 163840,
            maxOutput: null,
          ),
          ModelInfo(
            modelId: 'deepseek/deepseek-r1-0528',
            type: 'chat',
            nickname: 'DeepSeek: R1 0528',
            capabilities: ['tool_use'],
            contextWindow: 163840,
            maxOutput: null,
          ),
          ModelInfo(
            modelId: 'deepseek/deepseek-r1:free',
            type: 'chat',
            nickname: 'DeepSeek: R1 (free)',
            capabilities: ['tool_use'],
            contextWindow: 163840,
            maxOutput: null,
          ),
          ModelInfo(
            modelId: 'tngtech/deepseek-r1t2-chimera:free',
            type: 'chat',
            nickname: 'TNG: DeepSeek R1T2 Chimera (free)',
            capabilities: ['tool_use'],
            contextWindow: 163840,
            maxOutput: null,
          ),
          ModelInfo(
            modelId: 'google/gemini-2.5-pro',
            type: 'chat',
            nickname: 'Google: Gemini 2.5 Pro',
            capabilities: ['tool_use', 'vision'],
            contextWindow: 1048576,
            maxOutput: null,
          ),
          ModelInfo(
            modelId: 'google/gemini-2.5-flash-image-preview',
            type: 'chat',
            nickname: 'Google: Gemini 2.5 Flash Image Preview',
            capabilities: ['tool_use', 'vision'],
            contextWindow: 32768,
            maxOutput: null,
          ),
          ModelInfo(
            modelId: 'openai/gpt-5-chat',
            type: 'chat',
            nickname: 'OpenAI: GPT-5 Chat',
            capabilities: ['tool_use', 'vision'],
            contextWindow: 128000,
            maxOutput: null,
          ),
          ModelInfo(
            modelId: 'openai/gpt-4o-2024-11-20',
            type: 'chat',
            nickname: 'OpenAI: GPT-4o (2024-11-20)',
            capabilities: ['tool_use', 'vision'],
            contextWindow: 128000,
            maxOutput: null,
          ),
          ModelInfo(
            modelId: 'x-ai/grok-3-mini',
            type: 'chat',
            nickname: 'xAI: Grok 3 Mini',
            capabilities: ['tool_use'],
            contextWindow: 131072,
            maxOutput: null,
          ),
        ],
      ),
      ModelProvider(
        id: 'volcengine',
        name: 'VolcEngine',
        type: 'OpenAI',
        website: 'https://www.volcengine.com/',
        apiHost: 'https://ark.cn-beijing.volces.com',
        apiPath: '/api/v3/chat/completions',
        models: [
          ModelInfo(
            modelId: 'deepseek-v3-250324',
            contextWindow: 64000,
            capabilities: ['tool_use', 'reasoning'],
            maxOutput: null,
          ),
          ModelInfo(
            modelId: 'deepseek-r1-250528',
            contextWindow: 16384,
            capabilities: ['reasoning', 'tool_use'],
            maxOutput: null,
          ),
          ModelInfo(
            modelId: 'doubao-1-5-thinking-pro-250415',
            contextWindow: 128000,
            capabilities: ['reasoning'],
            maxOutput: null,
          ),
          ModelInfo(
            modelId: 'doubao-1.5-vision-pro-250328',
            contextWindow: 128000,
            capabilities: ['vision'],
            maxOutput: null,
          ),
          ModelInfo(
            modelId: 'doubao-embedding-text-240715',
            type: 'embedding',
            capabilities: [],
            contextWindow: null,
            maxOutput: null,
          ),
        ],
      ),
      ModelProvider(
        id: 'azure',
        name: 'Azure OpenAI',
        type: 'OpenAI',
        endpoint: 'https://<resource_name>.openai.azure.com',
        apiVersion: '2024-05-01-preview',
        models: [],
      ),
      ModelProvider(
        id: 'xai',
        name: 'xAI',
        type: 'OpenAI',
        website: 'https://x.ai/',
        apiHost: 'https://api.x.ai',
        models: [
          ModelInfo(
            modelId: 'grok-4-0709',
            contextWindow: 256000,
            capabilities: ['vision', 'tool_use', 'reasoning'],
            maxOutput: null,
          ),
          ModelInfo(
            modelId: 'grok-3',
            contextWindow: 131072,
            capabilities: ['tool_use'],
            maxOutput: null,
          ),
          ModelInfo(
            modelId: 'grok-3-mini',
            contextWindow: 131072,
            capabilities: ['tool_use', 'reasoning'],
            maxOutput: null,
          ),
          ModelInfo(
            modelId: 'grok-3-fast',
            contextWindow: 131072,
            capabilities: ['tool_use'],
            maxOutput: null,
          ),
          ModelInfo(
            modelId: 'grok-2-vision-1212',
            capabilities: ['vision'],
            contextWindow: 8192,
            maxOutput: null,
          ),
          ModelInfo(
            modelId: 'grok-2-1212',
            contextWindow: 128000,
            capabilities: [],
            maxOutput: null,
          ),
          ModelInfo(
            modelId: 'grok-vision-beta',
            capabilities: ['vision'],
            contextWindow: 8192,
            maxOutput: null,
          ),
          ModelInfo(
            modelId: 'grok-beta',
            contextWindow: 128000,
            capabilities: [],
            maxOutput: null,
          ),
        ],
      ),
      ModelProvider(
        id: 'mistralai',
        name: 'Mistral AI',
        type: 'OpenAI',
        website: 'https://mistral.ai',
        apiHost: 'https://api.mistral.ai/v1',
        models: [
          ModelInfo(
            modelId: 'pixtral-large-latest',
            contextWindow: 128000,
            capabilities: ['vision', 'tool_use'],
            maxOutput: null,
          ),
          ModelInfo(
            modelId: 'mistral-large-latest',
            contextWindow: 32000,
            capabilities: ['tool_use'],
            maxOutput: null,
          ),
          ModelInfo(
            modelId: 'mistral-medium-latest',
            contextWindow: 32000,
            capabilities: ['tool_use'],
            maxOutput: null,
          ),
          ModelInfo(
            modelId: 'mistral-small-latest',
            contextWindow: 32000,
            capabilities: ['tool_use'],
            maxOutput: null,
          ),
          ModelInfo(
            modelId: 'magistral-medium-latest',
            contextWindow: 32000,
            capabilities: ['reasoning', 'tool_use'],
            maxOutput: null,
          ),
          ModelInfo(
            modelId: 'magistral-small-latest',
            contextWindow: 32000,
            capabilities: ['reasoning', 'tool_use'],
            maxOutput: null,
          ),
          ModelInfo(
            modelId: 'codestral-22b-latest',
            contextWindow: 32000,
            capabilities: [],
            maxOutput: null,
          ),
          ModelInfo(
            modelId: 'mistral-embed',
            type: 'embedding',
            capabilities: [],
            contextWindow: null,
            maxOutput: null,
          ),
        ],
      ),
      ModelProvider(
        id: 'perplexity',
        name: 'Perplexity',
        type: 'OpenAI',
        website: 'https://www.perplexity.ai/',
        models: [
          ModelInfo(
            modelId: 'sonar',
            capabilities: [],
            contextWindow: null,
            maxOutput: null,
          ),
          ModelInfo(
            modelId: 'sonar-pro',
            capabilities: [],
            contextWindow: null,
            maxOutput: null,
          ),
          ModelInfo(
            modelId: 'sonar-reasoning',
            capabilities: [],
            contextWindow: null,
            maxOutput: null,
          ),
          ModelInfo(
            modelId: 'sonar-reasoning-pro',
            capabilities: [],
            contextWindow: null,
            maxOutput: null,
          ),
          ModelInfo(
            modelId: 'sonar-deep-research',
            capabilities: [],
            contextWindow: null,
            maxOutput: null,
          ),
        ],
      ),
      ModelProvider(
        id: 'groq',
        name: 'Groq',
        type: 'OpenAI',
        website: 'https://groq.com/',
        apiHost: 'https://api.groq.com/openai',
        models: [
          ModelInfo(
            modelId: 'llama-3.3-70b-versatile',
            contextWindow: 131072,
            maxOutput: 32768,
            capabilities: ['tool_use'],
          ),
          ModelInfo(
            modelId: 'moonshotai/kimi-k2-instruct',
            contextWindow: 131072,
            maxOutput: 16384,
            capabilities: ['tool_use'],
          ),
          ModelInfo(
            modelId: 'qwen/qwen3-32b',
            contextWindow: 131072,
            maxOutput: 40960,
            capabilities: ['tool_use'],
          ),
        ],
      ),
      ModelProvider(
        id: 'chatglm6b',
        name: 'ChatGLM6B',
        type: 'OpenAI',
        apiHost: 'https://open.bigmodel.cn/api/paas/v4/',
        models: [
          ModelInfo(
            modelId: 'glm-4.5',
            capabilities: ['reasoning', 'tool_use'],
            contextWindow: 128000,
            maxOutput: null,
          ),
          ModelInfo(
            modelId: 'glm-4.5-air',
            capabilities: ['reasoning', 'tool_use'],
            contextWindow: 128000,
            maxOutput: null,
          ),
          ModelInfo(
            modelId: 'glm-4.5v',
            capabilities: ['reasoning', 'vision', 'tool_use'],
            contextWindow: 64000,
            maxOutput: null,
          ),
          ModelInfo(
            modelId: 'glm-4-air',
            capabilities: ['tool_use'],
            contextWindow: 128000,
            maxOutput: null,
          ),
          ModelInfo(
            modelId: 'glm-4-plus',
            capabilities: ['tool_use'],
            contextWindow: 128000,
            maxOutput: null,
          ),
          ModelInfo(
            modelId: 'glm-4-flash',
            capabilities: ['tool_use'],
            contextWindow: 128000,
            maxOutput: null,
          ),
          ModelInfo(
            modelId: 'glm-4v-plus-0111',
            capabilities: ['vision', 'tool_use'],
            contextWindow: 16000,
            maxOutput: null,
          ),
          ModelInfo(
            modelId: 'glm-4v-flash',
            capabilities: ['vision', 'tool_use'],
            contextWindow: 16000,
            maxOutput: null,
          ),
        ],
      ),
    ];
  }
}
