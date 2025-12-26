class Recipe {
  final int id; // Favoriler ve yönlendirme için gerekli
  final String name;
  final String imageUrl; // Görsellik önemli
  final List<String> ingredients;
  final List<String> steps;
  final String category;
  final String cookingTime; // Örn: 30 dk
  final String difficulty; // Örn: Kolay, Orta

  Recipe({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.ingredients,
    required this.steps,
    required this.category,
    required this.cookingTime,
    required this.difficulty,
  });

  factory Recipe.fromJson(Map<String, dynamic> json) {
    return Recipe(
      id: json['id'],
      name: json['name'],
      imageUrl: json['imageUrl'],
      ingredients: List<String>.from(json['ingredients']),
      steps: List<String>.from(json['steps']),
      category: json['category'],
      cookingTime: json['cookingTime'],
      difficulty: json['difficulty'],
    );
  }
}
