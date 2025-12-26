import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:recipe_app/model/recipeModel.dart';

class RecipeService {
  Future<List<Recipe>> getRecipes() async {
    try {
      final String response = await rootBundle.loadString(
        'assets/recipes.json',
      );
      final List<dynamic> data = json.decode(response);
      return data.map((json) => Recipe.fromJson(json)).toList();
    } catch (e) {
      print("veri okuma hatası: $e");
      return [];
    }
  }

  // ML için veya Kategori bazlı filtreleme için yardımcı metodlar ekleyebilirsin
  Future<List<Recipe>> getRecipesByCategory(String categoryName) async {
    List<Recipe> allRecipes = await getRecipes();
    return allRecipes
        .where((recipe) => recipe.category == categoryName)
        .toList();
  }
}
