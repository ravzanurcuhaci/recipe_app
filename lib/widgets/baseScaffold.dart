import 'package:flutter/material.dart';
import 'package:recipe_app/utils/appColors.dart';
import 'package:recipe_app/utils/appStyles.dart';
import 'package:recipe_app/view/favoriesPage.dart';
import 'package:recipe_app/view/homePage.dart';
import 'package:recipe_app/view/profilePage.dart';

class BaseScaffold extends StatelessWidget {
  final Widget body;
  final String? title;
  final List<Widget>? actions;
  final bool isLoading;
  // Yeni eklediğimiz özellik: Hangi tab aktif?
  final int bottomNavIndex;

  const BaseScaffold({
    Key? key,
    required this.body,
    this.title,
    this.actions,
    this.isLoading = false,
    this.bottomNavIndex = -1, // Varsayılan -1 (Bar yok demek)
  }) : super(key: key);

  // Sayfa Değiştirme Fonksiyonu
  void _navigateToPage(BuildContext context, int index) {
    if (index == bottomNavIndex) return; // Zaten o sayfadaysak işlem yapma

    Widget page;
    switch (index) {
      case 0:
        page = const HomeView();
        break;
      case 1:
        // Buraya tıklandığında AI sayfası veya başka bir şey açılacaksa
        // Navigation yerine bir dialog da açtırabilirsin.
        // Şimdilik Favorilere yönlendiriyorum.
        page = ProfileView();
        break;
      case 2:
        page = FavoritesView();
        break;
      default:
        return;
    }

    // Animasyonsuz geçiş (Bar sabitmiş gibi görünsün diye)
    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        pageBuilder: (context, anim1, anim2) => page,
        transitionDuration: Duration.zero,
        reverseTransitionDuration: Duration.zero,
      ),
    );
  }

  // Yapay Zeka Butonuna Tıklanınca
  void _onAITap(BuildContext context) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text("AI Modülü Açılıyor... 🤖")));
    // İleride buraya: Navigator.push(context, MaterialPageRoute(builder: (_) => AIView()));
  }

  @override
  Widget build(BuildContext context) {
    // Alt barın görünüp görünmeyeceğine karar veriyoruz
    final bool showBottomNav = bottomNavIndex != -1;

    return Stack(
      children: [
        Scaffold(
          backgroundColor: AppColors.background,
          appBar: title != null
              ? AppBar(
                  title: Text(
                    title!,
                    style: AppTextStyles.header.copyWith(fontSize: 20),
                  ),
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  centerTitle: true,
                  automaticallyImplyLeading:
                      !showBottomNav, // Alt bar varsa geri butonu otomatik çıkmasın
                  actions: actions,
                )
              : null,

          body: SafeArea(
            bottom:
                !showBottomNav, // Alt bar varsa body'nin altını güvenli alana sıkıştırma (Bar üstüne binsin istemeyiz)
            child: Padding(padding: const EdgeInsets.all(20.0), child: body),
          ),

          // --- ORTA BUTTON (FAB) ---
          floatingActionButton: showBottomNav
              ? FloatingActionButton(
                  onPressed: () => _onAITap(context),
                  backgroundColor: AppColors.primary,
                  child: const Icon(
                    Icons.auto_awesome,
                    color: Colors.white,
                    size: 30,
                  ),
                )
              : null,
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,

          // --- ALT NAVİGASYON ---
          bottomNavigationBar: showBottomNav
              ? BottomAppBar(
                  shape: const CircularNotchedRectangle(),
                  notchMargin: 8.0,
                  child: SizedBox(
                    height: 60,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildNavItem(
                          context,
                          icon: Icons.home_rounded,
                          label: "Ana Sayfa",
                          index: 0,
                        ),
                        const SizedBox(width: 40), // FAB boşluğu
                        _buildNavItem(
                          context,
                          icon: Icons.favorite_rounded,
                          label: "Favoriler",
                          index: 2,
                        ), // Index 2 yaptık (Sağ taraf)
                      ],
                    ),
                  ),
                )
              : null,
        ),

        // LOADING EKRANI
        if (isLoading)
          Container(
            color: Colors.black54,
            child: const Center(
              child: CircularProgressIndicator(color: AppColors.primary),
            ),
          ),
      ],
    );
  }

  Widget _buildNavItem(
    BuildContext context, {
    required IconData icon,
    required String label,
    required int index,
  }) {
    final bool isSelected = bottomNavIndex == index;
    return InkWell(
      onTap: () => _navigateToPage(context, index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: isSelected ? AppColors.primary : Colors.grey,
            size: 28,
          ),
          Text(
            label,
            style: TextStyle(
              color: isSelected ? AppColors.primary : Colors.grey,
              fontSize: 12,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}
