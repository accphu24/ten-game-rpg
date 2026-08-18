import 'package:flutter/material.dart';
import 'main_menu_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Game RPG',
      debugShowCheckedModeBanner: false,
      home: const MainMenuScreen(),
    );
  }
}
