import 'package:flutter/material.dart';
import 'package:flame/game.dart';
import 'battle_manager.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  late final FlameGame _game;

  @override
  void initState() {
    super.initState();
    _game = FlameGame()..add(BattleManager(onBattleEnd: _showResult));
  }

  void _showResult(bool won) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => AlertDialog(
        title: Text(won ? 'THẮNG!' : 'THUA!'),
        content: Text(won ? 'Bạn đã hạ gục đối thủ.' : 'Bạn đã gục ngã.'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.of(context).pop();
            },
            child: const Text('VỀ MENU'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: GameWidget(game: _game));
  }
}
