import 'package:flutter/material.dart';
import 'package:recipe_app/widgets/baseScaffold.dart';

class ProfileView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const BaseScaffold(
      title: "Profil",

      body: Center(child: Text("Kullanıcı Ayarları Burada Olacak")),
    );
  }
}
