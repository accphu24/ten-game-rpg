import 'package:flutter/material.dart';

class GameScreen extends StatelessWidget {
  const GameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1a1a2e),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'GAMEPLAY\nĐANG XÂY DỰNG',
              textAlign: TextAlign.center,
              style: TextStyle(fontFamily: 'PressStart2P', fontSize: 14, color: Colors.white, height: 1.8),
            ),
            const SizedBox(height: 40),
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('QUAY LẠI', style: TextStyle(fontFamily: 'PressStart2P', fontSize: 10, color: Colors.white70)),
            ),
          ],
        ),
      ),
    );
  }
}
