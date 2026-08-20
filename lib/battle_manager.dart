import 'package:flame/components.dart';
import 'battle_engine.dart';
import 'fighter_sprite.dart';

class BattleManager extends Component {
  final void Function(bool won) onBattleEnd;
  final String playerImagePath;
  late BattleEngine engine;
  final Map<String, FighterSprite> sprites = {};

  BattleManager({required this.onBattleEnd, required this.playerImagePath});

  @override
  Future<void> onLoad() async {
    final fighters = [
      Fighter(id: 'player', isPlayer: true),
      Fighter(id: 'enemy1', isPlayer: false, attackDamage: 8),
    ];

    engine = BattleEngine(fighters: fighters, onAction: _onAction, onBattleEnd: onBattleEnd);

    final imagePaths = {
      'player': playerImagePath,
      'enemy1': 'enemies/skeleton.png',
    };

    for (var i = 0; i < fighters.length; i++) {
      final f = fighters[i];
      final sprite = FighterSprite(
        fighterId: f.id,
        isPlayer: f.isPlayer,
        imagePath: imagePaths[f.id]!,
        onTap: engine.playerAttack,
        position: Vector2(80.0 + i * 160, 200),
        hp: f.hp,
        maxHp: f.maxHp,
      );
      sprites[f.id] = sprite;
      await add(sprite);
    }

    _refreshTurnIndicator();
  }

  void _onAction(String actorId, String targetId, int damage) {
    final target = engine.fighters.firstWhere((f) => f.id == targetId);
    sprites[targetId]?.updateHp(target.hp);
    _refreshTurnIndicator();
  }

  void _refreshTurnIndicator() {
    for (final f in engine.fighters) {
      sprites[f.id]?.setTurn(f.id == engine.currentFighter.id && f.isAlive);
    }
  }
}
