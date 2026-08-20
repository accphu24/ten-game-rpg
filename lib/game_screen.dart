import 'package:flutter/material.dart';
import 'package:flame/game.dart';
import 'package:flame/components.dart';
import 'fighter_sprite.dart';

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
    camera.viewfinder.anchor = Anchor.topLeft;

    add(TextComponent(text: 'Test FighterSprite that', position: Vector2(20, 20)));

    final fs = FighterSprite(
      fighterId: 'test',
      isPlayer: true,
      imagePath: 'characters/preset_1.png',
      onTap: (id) {},
      position: Vector2(150, 150),
    );
    await add(fs);

    add(TextComponent(text: 'Da add xong FighterSprite', position: Vector2(20, 50)));
  }
}
