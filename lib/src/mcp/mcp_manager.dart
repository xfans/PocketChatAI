import 'package:openai_dart/openai_dart.dart';
import 'package:pocket_chat/src/mcp/weather_mcp.dart';

class MCPManager {
  MCPManager._();
  static final MCPManager instance = MCPManager._();

  final Map<String, ChatCompletionTool> _tools = {};
  final Map<String, Future<Map<String, dynamic>> Function(Map<String, dynamic>)> _executors = {};

  void register(String name, ChatCompletionTool tool, Future<Map<String, dynamic>> Function(Map<String, dynamic>) executor) {
    _tools[name] = tool;
    _executors[name] = executor;
  }

  List<ChatCompletionTool> tools() => _tools.values.toList();

  Future<Map<String, dynamic>> execute(String name, Map<String, dynamic> args) async {
    final fn = _executors[name];
    if (fn == null) {
      return {'error': 'unknown tool'};
    }
    return await fn(args);
  }

  void initDefaults() {
    register(WeatherMcp.function.name, WeatherMcp.tool, WeatherMcp.execute);
  }
}