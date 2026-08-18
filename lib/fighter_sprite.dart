import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flutter/material.dart';

class FighterSprite extends PositionComponent with TapCallbacks {
  final String fighterId;
  final bool isPlayer;
  final void Function(String targetId) onTap;
  int hp;
  final int maxHp;

  late TextComponent _hpText;
  late RectangleComponent _turnIndicator;

  FighterSprite({
    required this.fighterId,
    required this.isPlayer,
    required this.onTap,
    required Vector2 position,
    this.hp = 100,
    this.maxHp = 100,
  }) : super(position: position, size: Vector2(48, 64), anchor: Anchor.center);

  @override
  Future<void> onLoad() async {
    add(RectangleComponent(
      size: size,
      paint: Paint()..color = isPlayer ? Colors.blue : Colors.red,
    ));
    _hpText = TextComponent(text: '$hp/$maxHp', position: Vector2(size.x / 2, -12), anchor: Anchor.center);
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
