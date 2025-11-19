import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:openai_dart/openai_dart.dart';

class WeatherMcp {
  static final FunctionObject function =  FunctionObject(
    name: 'get_current_weather',
    description: 'Get the current weather in a given location',
    parameters: {
      'type': 'object',
      'properties': {
        'location': {
          'type': 'string',
          'description': 'The city and state, e.g. San Francisco, CA',
        },
        'reason': {
          'type': 'string',
          'description': 'The user is asking about the weather in Beijing; I need to look it up.',
        },
      },
      'required': ['location'],
    },
  );

  static final ChatCompletionTool tool = ChatCompletionTool(
    type: ChatCompletionToolType.function,
    function: function,
  );

  static Future<Map<String, dynamic>> execute(Map<String, dynamic> args) async {
    final location = (args['location'] ?? '').toString();
    final reason = (args['reason'] ?? '').toString();
    final unit = (args['unit'] ?? 'celsius').toString();
    if (location.isEmpty) {
      return {'error': 'missing location'};
    }
    print("location:$location");
    
    final geoUri = Uri.parse('https://geocoding-api.open-meteo.com/v1/search?name=${Uri.encodeQueryComponent(location.trim())}&count=1&language=zh&format=json');

    final geoRes = await http.get(geoUri);
    if (geoRes.statusCode != 200) {
      return {'error': 'geocoding failed'};
    }
    final geo = jsonDecode(geoRes.body);

    final results = geo['results'];
    if (results is! List || results.isEmpty) {
      return {'error': 'location not found'};
    }
    final r = results.first as Map<String, dynamic>;
    final lat = r['latitude'];
    final lon = r['longitude'];
    final weatherUri = Uri.parse('https://api.open-meteo.com/v1/forecast?latitude=$lat&longitude=$lon&current_weather=true');
    final wRes = await http.get(weatherUri);
    if (wRes.statusCode != 200) {
      return {'error': 'weather fetch failed'};
    }
    final w = jsonDecode(wRes.body) as Map<String, dynamic>;

    final cw = (w['current_weather'] ?? {}) as Map<String, dynamic>;
    double tempC;
    final tRaw = cw['temperature'];
    if (tRaw is num) {
      tempC = tRaw.toDouble();
    } else {
      tempC = 0;
    }
    final temp = unit == 'fahrenheit' ? (tempC * 9 / 5 + 32) : tempC;
    return {
      'reason': reason,
      'location': location,
      'latitude': lat,
      'longitude': lon,
      'temperature': temp,
      'unit': unit,
      'windspeed': cw['windspeed'],
      'source': 'open-meteo',
    };
  }
}