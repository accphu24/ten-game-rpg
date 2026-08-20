import 'package:flutter/material.dart';

class GameScreen extends StatelessWidget {
  const GameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.deepOrange,
      body: Center(
        child: Text(
          'TEST MAN HINH GAME',
          style: TextStyle(fontSize: 28, color: Colors.white),
        ),
      ),
    );
  }
}
