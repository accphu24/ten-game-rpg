import 'package:flutter/material.dart';
import 'package:flame/game.dart';
import 'package:flame/components.dart';

class GameScreen extends StatelessWidget {
  const GameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: GameWidget(game: MinimalGame()));
  }
}

class MinimalGame extends FlameGame {
  @override
  Color backgroundColor() => const Color(0xFF1a1a2e);

  @override
  Future<void> onLoad() async {
    add(RectangleComponent(
      position: Vector2(50, 50),
      size: Vector2(100, 100),
      paint: Paint()..color = const Color(0xFFFF0000),
    ));
  }
}
