import 'dart:convert';
import 'package:http/http.dart' as http;

class WebSearchResult {
  final String title;
  final String description;
  final String url;
  WebSearchResult(this.title, this.description, this.url);
}

class WebSearchService {
  Future<List<WebSearchResult>> search(String query) async {
    final uri = Uri.parse('https://api.duckduckgo.com/?q=${Uri.encodeQueryComponent(query)}&format=json&no_html=1&skip_disambig=1');
    final res = await http.get(uri);
    if (res.statusCode != 200) return [];
    final data = jsonDecode(res.body);
    final List<WebSearchResult> out = [];
    void addItem(dynamic item) {
      final t = (item['Text'] ?? '').toString();
      final u = (item['FirstURL'] ?? '').toString();
      if (t.isEmpty || u.isEmpty) return;
      out.add(WebSearchResult(t, '', u));
    }
    if (data is Map<String, dynamic>) {
      final related = data['RelatedTopics'];
      if (related is List) {
        for (final rt in related) {
          if (rt is Map && rt.containsKey('Text')) {
            addItem(rt);
          } else if (rt is Map && rt['Topics'] is List) {
            for (final t in rt['Topics']) {
              if (t is Map) addItem(t);
            }
          }
        }
      }
      final results = data['Results'];
      if (results is List) {
        for (final r in results) {
          if (r is Map) addItem(r);
        }
      }
    }
    return out.take(5).toList();
  }
}