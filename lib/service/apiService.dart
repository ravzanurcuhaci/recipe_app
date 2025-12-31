import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/recipeModelAI.dart';

class ApiService {
  final String baseUrl;

  ApiService({required this.baseUrl});

  Future<List<String>> fetchSuggestions(
    List<String> ingredients, {
    int topN = 5,
  }) async {
    final response = await http.post(
      Uri.parse('$baseUrl/suggest'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'ingredients': ingredients, 'top_n': topN}),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return RecipeResponse.fromJson(data).suggestions;
    } else {
      throw Exception("API Hatası: ${response.statusCode}");
    }
  }
}
