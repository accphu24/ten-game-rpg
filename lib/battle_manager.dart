import 'package:flame/components.dart';
import 'game_connection.dart';
import 'battle_player_sprite.dart';

class BattleManager extends Component {
  final String myPlayerId;
  final GameConnection connection;
  final Map<String, BattlePlayerSprite> sprites = {};

  BattleManager({required this.myPlayerId, required this.connection});

  void handleMessage(Map<String, dynamic> msg) {
    switch (msg['type']) {
      case 'join':
        _rebuildSprites(List<String>.from(msg['players']));
        break;
      case 'action_result':
        final hp = Map<String, dynamic>.from(msg['hp']);
        hp.forEach((id, value) => sprites[id]?.updateHp(value as int));
        for (final e in sprites.entries) {
          e.value.setTurn(e.key == msg['next_turn']);
        }
        break;
      case 'leave':
        final id = msg['player'] as String;
        sprites[id]?.removeFromParent();
        sprites.remove(id);
        break;
    }
  }

  void _rebuildSprites(List<String> playerIds) {
    for (var i = 0; i < playerIds.length; i++) {
      final id = playerIds[i];
      if (sprites.containsKey(id)) continue;
      final sprite = BattlePlayerSprite(
        playerId: id,
        myPlayerId: myPlayerId,
        connection: connection,
        position: Vector2(80.0 + i * 90, 200),
      );
      sprites[id] = sprite;
      add(sprite);
    }
  }
}
