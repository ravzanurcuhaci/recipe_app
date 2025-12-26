import 'package:flutter/material.dart';
import '../model/recipeModel.dart';
import '../service/recipeService.dart';

class HomeViewModel extends ChangeNotifier {
  final RecipeService _service = RecipeService();

  // 1. YEDEK LİSTE (Tüm veriler burada saklanır)
  List<Recipe> _allRecipes = [];

  // 2. EKRAN LİSTESİ (Kullanıcı bunu görür)
  List<Recipe> _recipes = [];

  bool _isLoading = false;

  List<Recipe> get recipes => _recipes;
  bool get isLoading => _isLoading;

  // Kategorilerin, JSON dosyasındaki "category" alanıyla BİREBİR aynı olmalı
  final List<String> categories = [
    "Tümü",
    "Kahvaltı",
    "Akşam Yemeği",
    "Tatlı",
    "Çorba",
    "Salata",
  ];

  String selectedCategory = "Tümü";

  Future<void> fetchRecipes() async {
    if (_allRecipes.isNotEmpty) return;
    _isLoading = true;
    notifyListeners();

    // Veriyi çekince her iki listeyi de dolduruyoruz
    _allRecipes = await _service.getRecipes();
    _recipes = List.from(_allRecipes); // Başlangıçta hepsi görünsün

    _isLoading = false;
    notifyListeners();
  }

  void selectCategory(String category) {
    selectedCategory = category;

    // Debug: Ne seçildiğini görelim
    print("Seçilen Kategori: '$category'");

    if (category == "Tümü") {
      _recipes = List.from(_allRecipes);
    } else {
      _recipes = _allRecipes.where((item) {
        // Debug: Her bir tarifin kategorisini görelim
        // print("Tarif Kategorisi: '${item.category}' vs Seçilen: '$category'");

        // Trim() kullanarak görünmez boşlukları temizleyelim
        return item.category.trim() == category.trim();
      }).toList();
    }

    // Sonuçta kaç tane buldu?
    print("Bulunan Sonuç Sayısı: ${_recipes.length}");

    notifyListeners();
  }

  final List<Recipe> _favoriteRecipes = [];
  List<Recipe> get favoriteRecipes => _favoriteRecipes;

  void toggleFavorite(Recipe recipe) {
    final isExist = _favoriteRecipes.any((element) => element.id == recipe.id);
    if (isExist) {
      _favoriteRecipes.removeWhere((element) => element.id == recipe.id);
    } else {
      _favoriteRecipes.add(recipe);
    }
    notifyListeners();
  }

  bool isFavorite(Recipe recipe) {
    return _favoriteRecipes.any((element) => element.id == recipe.id);
  }
}
