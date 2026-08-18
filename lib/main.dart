import 'package:flutter/material.dart';
import 'package:flame/game.dart';
import 'battle_manager.dart';
import 'game_connection.dart';

void main() {
  runApp(GameWidget(game: MyGame(myPlayerId: 'a')));
}

class MyGame extends FlameGame {
  final String myPlayerId;
  late GameConnection connection;
  late BattleManager battleManager;

  MyGame({required this.myPlayerId});

  @override
  Future<void> onLoad() async {
    connection = GameConnection(
      playerId: myPlayerId,
      onMessage: (msg) => battleManager.handleMessage(msg),
    );
    battleManager = BattleManager(myPlayerId: myPlayerId, connection: connection);
    add(battleManager);
    await connection.connect('localhost', 8000);
  }
}
