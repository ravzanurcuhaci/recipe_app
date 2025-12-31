class RecipeResponse {
  final List<String> suggestions;

  RecipeResponse({required this.suggestions});

  factory RecipeResponse.fromJson(Map<String, dynamic> json) {
    return RecipeResponse(
      suggestions: List<String>.from(json['suggestions'] ?? []),
    );
  }
}
