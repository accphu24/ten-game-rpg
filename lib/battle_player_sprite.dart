import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flutter/material.dart';
import 'game_connection.dart';

class BattlePlayerSprite extends PositionComponent with TapCallbacks {
  final String playerId;
  final String myPlayerId;
  final GameConnection connection;
  int hp;

  late TextComponent _hpText;
  late RectangleComponent _turnIndicator;

  BattlePlayerSprite({
    required this.playerId,
    required this.myPlayerId,
    required this.connection,
    required Vector2 position,
    this.hp = 100,
  }) : super(position: position, size: Vector2(48, 64), anchor: Anchor.center);

  @override
  Future<void> onLoad() async {
    add(RectangleComponent(
      size: size,
      paint: Paint()..color = playerId == myPlayerId ? Colors.blue : Colors.red,
    ));
    _hpText = TextComponent(text: '$hp HP', position: Vector2(size.x / 2, -12), anchor: Anchor.center);
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
    _hpText.text = '$hp HP';
  }

  void setTurn(bool value) {
    _turnIndicator.paint.color = value ? Colors.yellow : Colors.transparent;
  }

  @override
  void onTapDown(TapDownEvent event) {
    if (playerId == myPlayerId) return;
    connection.sendAction(playerId, damage: 10);
  }
}
