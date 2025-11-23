import 'package:openai_dart/openai_dart.dart';
import 'package:pocket_chat/src/models/model_provider.dart';

class OpenAiCompatible {
  late final OpenAIClient client;
  final ModelProvider modelProvider;
  //构造方法
  OpenAiCompatible(this.modelProvider){
    client = OpenAIClient(apiKey: modelProvider.apiKey,baseUrl: modelProvider.apiHost);
  }

  Stream<CreateChatCompletionStreamResponse> completion(List<ChatCompletionMessage> messages ,{List<ChatCompletionTool>? tools}){
    final res =  client.createChatCompletionStream(
      request: CreateChatCompletionRequest(
        model: ChatCompletionModel.modelId(modelProvider.models[0].modelId),
        messages: messages,
        tools: tools,
        stream: true,
      ),
    );
    return res;
  }
}