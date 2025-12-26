import 'package:flutter/material.dart';
import 'package:recipe_app/model/recipeModel.dart';
import 'package:recipe_app/utils/appColors.dart';
import 'package:recipe_app/utils/appStyles.dart';

class RecipeCard extends StatelessWidget {
  final Recipe recipe;
  final bool isFavorite;
  final VoidCallback onFavoritePressed;

  const RecipeCard({
    Key? key,
    required this.recipe,
    this.isFavorite = false,
    required this.onFavoritePressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        children: [
          // 1. Resim Alanı
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              recipe.imageUrl,
              width: 90,
              height: 90,
              fit: BoxFit.cover,
              errorBuilder: (ctx, err, stack) => Container(
                width: 90,
                height: 90,
                color: Colors.grey[300],
                child: const Icon(Icons.error),
              ),
            ),
          ),
          const SizedBox(width: 15),

          // 2. Bilgi Alanı
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(recipe.name, style: AppTextStyles.cardTitle),
                const SizedBox(height: 5),
                Text(
                  recipe.category,
                  style: TextStyle(
                    color: AppColors.primary,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Icons.timer, size: 14, color: Colors.grey),
                    Text(
                      " ${recipe.cookingTime}  ",
                      style: const TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                    const Icon(Icons.bar_chart, size: 14, color: Colors.grey),
                    Text(
                      " ${recipe.difficulty}",
                      style: const TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // 3. Favori Butonu
          IconButton(
            icon: Icon(
              isFavorite
                  ? Icons.favorite
                  : Icons.favorite_border, // Dolu veya boş kalp
              color: isFavorite ? Colors.red : Colors.grey, // Kırmızı veya gri
            ),
            onPressed: onFavoritePressed, // Tıklanınca fonksiyonu çalıştır
          ),
        ],
      ),
    );
  }
}
