import 'package:openai_dart/openai_dart.dart';
import 'package:pocket_chat/src/models/model_provider.dart';

class OpenAiCompatible {
  late final OpenAIClient client;
  final ModelProvider modelProvider;
  //构造方法
  OpenAiCompatible(this.modelProvider){
    client = OpenAIClient(apiKey: modelProvider.apiKey,baseUrl: modelProvider.apiHost);
  }

  Future<String?> completion(String  message) async{
    final res = await client.createChatCompletion(
      request: CreateChatCompletionRequest(
        model: ChatCompletionModel.modelId(modelProvider.models[0].modelId),
        messages: [
          ChatCompletionMessage.user(
            content: ChatCompletionUserMessageContent.string(message),
          ),
        ],
      ),
    );
    return res.choices.first.message.content;
  }
}