import 'package:flutter/material.dart';
import 'package:flame/game.dart';
import 'package:flame/components.dart';
import 'battle_manager.dart';
import 'save_service.dart';

class BattleGame extends FlameGame {
  final void Function(bool won) onBattleEnd;
  final String playerImagePath;

  BattleGame({required this.onBattleEnd, required this.playerImagePath});

  @override
  Color backgroundColor() => const Color(0xFF1a1a2e);

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    camera.viewfinder.anchor = Anchor.topLeft;

    // hinh vuong test: khong qua anh, khong qua manager, chi de xem world co ve duoc gi khong
    world.add(RectangleComponent(
      position: Vector2(50, 50),
      size: Vector2(100, 100),
      paint: Paint()..color = const Color(0xFFFF0000),
    ));

    await world.add(BattleManager(onBattleEnd: onBattleEnd, playerImagePath: playerImagePath));
  }
}

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  BattleGame? _game;

  @override
  void initState() {
    super.initState();
    _setup();
  }

  Future<void> _setup() async {
    final save = await SaveService().load();
    final preset = save?.characterPreset ?? 'preset_1';
    setState(() {
      _game = BattleGame(onBattleEnd: _showResult, playerImagePath: 'characters/$preset.png');
    });
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
    if (_game == null) {
      return const Scaffold(
        backgroundColor: Color(0xFF1a1a2e),
        body: Center(child: CircularProgressIndicator(color: Colors.white)),
      );
    }
    return Scaffold(body: SizedBox.expand(child: GameWidget(game: _game!)));
  }
}
