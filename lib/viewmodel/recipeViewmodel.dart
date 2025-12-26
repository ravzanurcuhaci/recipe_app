import 'package:flutter/material.dart';
import 'package:recipe_app/model/recipeModel.dart';
import 'package:recipe_app/service/recipeService.dart';

class RecipeViewModel extends ChangeNotifier {
  final RecipeService _service = RecipeService();
  List<Recipe> _recipes = [];
  List<Recipe> get recipes => _recipes;

  String _selectedCategory = 'All';
  String get selectedCategory => _selectedCategory;

  Future<void> fetchRecipes() async {
    _recipes = await _service.getRecipes();
    notifyListeners();
  }

  void filterByCategory(String category) {
    _selectedCategory = category;
    notifyListeners();
  }

  List<Recipe> get filteredRecipes {
    if (_selectedCategory == 'All') return _recipes;
    return _recipes.where((r) => r.category == _selectedCategory).toList();
  }
}
