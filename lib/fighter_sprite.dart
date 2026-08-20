import 'dart:async';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/flame.dart';
import 'package:flutter/material.dart';

class FighterSprite extends PositionComponent with TapCallbacks {
  final String fighterId;
  final bool isPlayer;
  final String imagePath;
  final void Function(String targetId) onTap;
  int hp;
  final int maxHp;

  late TextComponent _hpText;
  late RectangleComponent _turnIndicator;

  FighterSprite({
    required this.fighterId,
    required this.isPlayer,
    required this.imagePath,
    required this.onTap,
    required Vector2 position,
    this.hp = 100,
    this.maxHp = 100,
  }) : super(position: position, size: Vector2(96, 96), anchor: Anchor.center);

  @override
  Future<void> onLoad() async {
    try {
      final image = await Flame.images
          .load(imagePath)
          .timeout(const Duration(seconds: 5));
      final sprite = Sprite(image, srcPosition: Vector2(0, 2 * 64), srcSize: Vector2(64, 64));
      add(SpriteComponent(sprite: sprite, size: size));
    } catch (e) {
      add(RectangleComponent(
        size: size,
        paint: Paint()..color = isPlayer ? Colors.blue : Colors.red,
      ));
    }

    _hpText = TextComponent(
      text: '$hp/$maxHp',
      position: Vector2(size.x / 2, -14),
      anchor: Anchor.center,
    );
    add(_hpText);

    _turnIndicator = RectangleComponent(
      size: Vector2(size.x + 8, 4),
      position: Vector2(-4, size.y + 4),
      paint: Paint()..color = Colors.transparent,
    );
    add(_turnIndicator);
  }

  void updateHp(int newHp) {
    hp = newHp;
    _hpText.text = '$hp/$maxHp';
  }

  void setTurn(bool value) {
    _turnIndicator.paint.color = value ? Colors.yellow : Colors.transparent;
  }

  @override
  void onTapDown(TapDownEvent event) {
    if (isPlayer) return;
    onTap(fighterId);
  }
}
