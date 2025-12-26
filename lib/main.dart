import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipe_app/view/homePage.dart';
import 'package:recipe_app/viewmodel/homeViewmodel.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        // HomeViewModel'i burada oluşturuyoruz
        ChangeNotifierProvider(create: (_) => HomeViewModel()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: HomeView(),
    );
  }
}
