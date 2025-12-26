import 'package:flutter/material.dart';
import '../model/recipeModel.dart'; // Model ismini kontrol et
import '../widgets/baseScaffold.dart';
import '../utils/appColors.dart';
import '../utils/appStyles.dart';

class RecipeDetailView extends StatelessWidget {
  final Recipe recipe;

  const RecipeDetailView({Key? key, required this.recipe}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // bottomNavIndex vermiyoruz, böylece BaseScaffold otomatik "Geri" butonu koyuyor.
    return BaseScaffold(
      title: recipe.name,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. Büyük Resim
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.network(
                recipe.imageUrl,
                width: double.infinity,
                height: 250,
                fit: BoxFit.cover,
                errorBuilder: (ctx, err, stack) => Container(
                  height: 250,
                  color: Colors.grey[300],
                  child: const Center(
                    child: Icon(Icons.broken_image, size: 50),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),

            // 2. İstatistikler (Süre, Zorluk vb.)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildStatBadge(Icons.timer, recipe.cookingTime),
                _buildStatBadge(Icons.bar_chart, recipe.difficulty),
                _buildStatBadge(
                  Icons.restaurant,
                  "${recipe.ingredients.length} Malzeme",
                ),
              ],
            ),

            const SizedBox(height: 20),
            const Divider(),

            // 3. Malzemeler
            const Text("Malzemeler", style: AppTextStyles.header),
            const SizedBox(height: 10),
            ...recipe.ingredients.map(
              (item) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: Row(
                  children: [
                    const Icon(
                      Icons.check_circle,
                      color: AppColors.primary,
                      size: 20,
                    ),
                    const SizedBox(width: 10),
                    Text(item, style: const TextStyle(fontSize: 16)),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),
            const Divider(),

            // 4. Yapılış Adımları
            const Text("Nasıl Yapılır?", style: AppTextStyles.header),
            const SizedBox(height: 10),
            ListView.separated(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: recipe.steps.length,
              separatorBuilder: (ctx, index) => const SizedBox(height: 15),
              itemBuilder: (context, index) {
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      radius: 12,
                      backgroundColor: AppColors.primary,
                      child: Text(
                        "${index + 1}",
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        recipe.steps[index],
                        style: const TextStyle(fontSize: 16, height: 1.5),
                      ),
                    ),
                  ],
                );
              },
            ),

            const SizedBox(height: 50), // Altta biraz boşluk bırakalım
          ],
        ),
      ),
    );
  }

  // Ufak yardımcı widget (Süre vb. kutucuklar için)
  Widget _buildStatBadge(IconData icon, String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Row(
        children: [
          Icon(icon, color: AppColors.primary, size: 18),
          const SizedBox(width: 5),
          Text(text, style: const TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
