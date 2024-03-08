import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:hashcode/models/visualization_data.dart';

class ApiService {
  static const baseUrl = 'http://your-backend-url';

  static Future<VisualizationData> visualizeParagraph(String paragraph) async {
    final response = await http.post(
      Uri.parse('$baseUrl/visualize'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'paragraph': paragraph}),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return VisualizationData(
        image: data['image'],
        audio: data['audio'],
      );
    } else {
      throw Exception('Failed to generate visualization');
    }
  }
}
