
import 'package:openai_dart/openai_dart.dart';

class DatetimeMcp {
  static final FunctionObject function =  FunctionObject(
    name: 'get_current_data_time',
    description: 'Get the current date and time',
    parameters: {
      'type': 'object',
      'properties': {

      },
    },
  );

  static final ChatCompletionTool tool = ChatCompletionTool(
    type: ChatCompletionToolType.function,
    function: function,
  );

  static Future<Map<String, dynamic>> execute(Map<String, dynamic> args) async {
    final timezone = (args['timezone'] ?? '').toString();
    
    var dateTime = DateTime.now();
    if(timezone.isNotEmpty){
      dateTime = DateTime.now().toUtc();
    }
    //格式化1991-01-01 00:00:00

    final date = dateTime.toIso8601String().substring(0, 10);
    final time = dateTime.toIso8601String().substring(11, 19);
    return {
      'date': date,
      'time': time,
      'timezone': timezone,
    };
  }
}