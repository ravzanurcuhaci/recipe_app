import 'package:flutter/material.dart';
import '../service/apiService.dart';
import '../model/recipeModel.dart';

class AiViewModel extends ChangeNotifier {
  final ApiService apiService;

  AiViewModel({required this.apiService});

  List<Recipe> recipes = [];
  bool isLoading = false;
  String errorMessage = "";

  Future<void> getRecipeSuggestions(List<String> ingredients) async {
    isLoading = true;
    errorMessage = "";
    notifyListeners();

    try {
      final suggestions = await apiService.fetchSuggestions(ingredients);

      recipes = suggestions.asMap().entries.map((e) {
        return Recipe(
          id: e.key + 1,
          name: e.value,
          imageUrl: "https://images.unsplash.com/photo-1546069901-ba9599a7e63c",
          ingredients: ingredients,
          steps: ["AI tarafından önerildi"],
          category: "AI Chef",
          cookingTime: "? dk",
          difficulty: "Bilinmiyor",
        );
      }).toList();
    } catch (e) {
      errorMessage = e.toString();
    }

    isLoading = false;
    notifyListeners();
  }
}
