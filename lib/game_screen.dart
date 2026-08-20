import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flame/game.dart';
import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame/sprite.dart';

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

    add(TextComponent(text: 'Dang tai anh...', position: Vector2(50, 170)));

    try {
      final image = await Flame.images
          .load('characters/preset_1.png')
          .timeout(const Duration(seconds: 5));
      final sprite = Sprite(image, srcPosition: Vector2(0, 128), srcSize: Vector2(64, 64));
      add(SpriteComponent(sprite: sprite, size: Vector2(96, 96), position: Vector2(200, 50)));
      add(TextComponent(text: 'ANH OK!', position: Vector2(50, 200)));
    } on TimeoutException {
      add(TextComponent(text: 'TIMEOUT - anh khong load duoc sau 5s', position: Vector2(50, 200)));
    } catch (e) {
      add(TextComponent(text: 'LOI: $e', position: Vector2(50, 200)));
    }
  }
}
