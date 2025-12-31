import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipe_app/utils/appColors.dart';
import 'package:recipe_app/viewmodel/aiViewmodel.dart';
import 'package:recipe_app/widgets/customButton.dart';
import 'package:recipe_app/widgets/recipeCard.dart';

class AiPage extends StatefulWidget {
  const AiPage({super.key});

  @override
  State<AiPage> createState() => _AiPageState();
}

class _AiPageState extends State<AiPage> {
  // Kullanıcıdan veri almak için kontrolcü
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose(); // Hafıza yönetimi için şart
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // ViewModel'i dinliyoruz
    final aiViewModel = Provider.of<AiViewModel>(context);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text(
          "Yapay Zeka Şef 👨‍🍳",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.transparent, // Modern görünüm
        elevation: 0,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            // 1. INPUT ALANI (Malzeme Girişi)
            Container(
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
              child: TextField(
                controller: _controller,
                style: const TextStyle(
                  color: AppColors.textDark, // Yazı rengini Siyah yaptık
                  fontSize: 16, // Okunabilirlik için boyut
                ),
                cursorColor: AppColors.primary,
                decoration: const InputDecoration(
                  labelText: "Malzemeler (örn: patates, yumurta)",
                  hintText: "Evinizde ne var?",
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 15,
                  ),
                  suffixIcon: Icon(Icons.search, color: AppColors.primary),
                ),
              ),
            ),

            const SizedBox(height: 20),

            // 2. BUTON (CustomButton Widget)
            CustomButton(
              text: "Tarif Öner",
              isLoading:
                  aiViewModel.isLoading, // Yükleniyor durumu VM'den gelir
              onPressed: () {
                // Klavyeyi kapat
                FocusScope.of(context).unfocus();

                if (_controller.text.isNotEmpty) {
                  // Virgülle ayır ve boşlukları temizle
                  List<String> ingredients = _controller.text
                      .split(',')
                      .map((e) => e.trim())
                      .where((e) => e.isNotEmpty) // Boş girdileri sil
                      .toList();

                  // İsteği gönder
                  aiViewModel.getRecipeSuggestions(ingredients);
                } else {
                  // Boşsa uyarı göster
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Lütfen en az bir malzeme girin"),
                    ),
                  );
                }
              },
            ),

            const SizedBox(height: 20),

            // 3. SONUÇ LİSTESİ veya HATA MESAJI
            if (aiViewModel.errorMessage.isNotEmpty)
              // Hata Durumu
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Text(
                  aiViewModel.errorMessage,
                  style: const TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              )
            else if (aiViewModel.recipes.isEmpty && !aiViewModel.isLoading)
              // Başlangıç Durumu (Boş Ekran)
              const Expanded(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.restaurant_menu, size: 80, color: Colors.grey),
                      SizedBox(height: 10),
                      Text(
                        "Malzemeleri gir, şef sana özel tarifler sunsun!",
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                ),
              )
            else
              // Veri Geldiğinde Liste
              Expanded(
                child: ListView.builder(
                  itemCount: aiViewModel.recipes.length,
                  itemBuilder: (context, index) {
                    // ViewModel zaten bize hazır Recipe objesi veriyor
                    final recipe = aiViewModel.recipes[index];

                    return RecipeCard(
                      recipe: recipe,
                      isFavorite:
                          false, // Favori mantığı backend'e bağlanınca değişir
                      onFavoritePressed: () {
                        // Tıklama aksiyonu
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              "${recipe.name} favorilere eklendi (Demo)",
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}
