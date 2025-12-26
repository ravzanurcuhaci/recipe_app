import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodel/homeViewmodel.dart';
import '../widgets/baseScaffold.dart';
import '../widgets/recipeCard.dart';
import 'recipeDetailPage.dart'; // Detay sayfası importu

class FavoritesView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // ViewModel'i dinliyoruz
    final viewModel = context.watch<HomeViewModel>();
    final favorites = viewModel.favoriteRecipes;

    return BaseScaffold(
      title: "Favorilerim",
      bottomNavIndex: 2, // Sağ taraftaki buton aktif görünsün
      body: favorites.isEmpty
          ? const Center(
              child: Text(
                "Henüz favori tarifin yok.\nBiraz eklemeye ne dersin? ❤️",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey, fontSize: 16),
              ),
            )
          : ListView.builder(
              itemCount: favorites.length,
              itemBuilder: (context, index) {
                final recipe = favorites[index];

                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => RecipeDetailView(recipe: recipe),
                      ),
                    );
                  },
                  child: RecipeCard(
                    recipe: recipe,
                    isFavorite:
                        true, // Burası zaten favoriler sayfası, hepsi true
                    onFavoritePressed: () {
                      // Buradan da favoriden çıkarmak isteyebilir
                      viewModel.toggleFavorite(recipe);
                    },
                  ),
                );
              },
            ),
    );
  }
}
