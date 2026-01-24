import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipe_app/utils/appColors.dart';
import 'package:recipe_app/utils/appStyles.dart';
import 'package:recipe_app/view/profilePage.dart';
import 'package:recipe_app/view/recipeDetailPage.dart';
import 'package:recipe_app/viewmodel/homeViewmodel.dart';
import 'package:recipe_app/widgets/AiBanner.dart';
import 'package:recipe_app/widgets/baseScaffold.dart';
import 'package:recipe_app/widgets/recipeCard.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<HomeViewModel>().fetchRecipes();
    });
  }

  @override
  Widget build(BuildContext context) {
    // ViewModel'i burada tanımlayalım ki aşağıda tekrar tekrar yazmayalım
    final viewModel = context.watch<HomeViewModel>();

    return BaseScaffold(
      // Başlık ve Aksiyonlar
      title: "Lezzet Dünyası",
      bottomNavIndex: 0, // <-- BEN SOL TARAFTAYIM
      actions: [
        IconButton(
          icon: const Icon(Icons.person),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ProfileView()),
            );
          },
        ),
      ],
      // Loading Durumu (ViewModel'den geliyor)
      isLoading: viewModel.isLoading,

      // Ana İçerik
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. AI Banner
            AIBanner(),

            const SizedBox(height: 25),

            // 2. Kategoriler
            SizedBox(
              height: 40,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: viewModel.categories.length,
                itemBuilder: (context, index) {
                  final cat = viewModel.categories[index];
                  final isSelected = cat == viewModel.selectedCategory;
                  return GestureDetector(
                    onTap: () => viewModel.selectCategory(cat),
                    child: Container(
                      margin: const EdgeInsets.only(right: 10),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: isSelected ? AppColors.primary : Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Colors.grey.shade300),
                      ),
                      child: Text(
                        cat,
                        style: TextStyle(
                          color: isSelected ? Colors.white : Colors.black,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 25),

            const Text("Popüler Tarifler", style: AppTextStyles.header),
            const SizedBox(height: 15),

            ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: viewModel.recipes.length,
              itemBuilder: (context, index) {
                final currentRecipe = viewModel.recipes[index];

                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            RecipeDetailView(recipe: currentRecipe),
                      ),
                    );
                  },
                  child: RecipeCard(
                    recipe: currentRecipe,
                    isFavorite: viewModel.isFavorite(currentRecipe),
                    onFavoritePressed: () {
                      viewModel.toggleFavorite(currentRecipe);
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
