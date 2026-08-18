class Fighter {
  final String id;
  final bool isPlayer;
  int hp;
  final int maxHp;
  final int attackDamage;

  Fighter({
    required this.id,
    required this.isPlayer,
    this.hp = 100,
    this.maxHp = 100,
    this.attackDamage = 10,
  });

  bool get isAlive => hp > 0;
}

class BattleEngine {
  final List<Fighter> fighters;
  int currentTurnIndex = 0;
  final void Function(String actorId, String targetId, int damage) onAction;
  final void Function(bool won) onBattleEnd;

  BattleEngine({required this.fighters, required this.onAction, required this.onBattleEnd});

  Fighter get currentFighter => fighters[currentTurnIndex];

  bool get playerWon => fighters.where((f) => !f.isPlayer).every((f) => !f.isAlive);
  bool get playerLost => fighters.where((f) => f.isPlayer).every((f) => !f.isAlive);

  void playerAttack(String targetId) {
    if (!currentFighter.isPlayer) return;
    _resolveAttack(currentFighter.id, targetId);
  }

  void _resolveAttack(String actorId, String targetId) {
    final actor = fighters.firstWhere((f) => f.id == actorId);
    final target = fighters.firstWhere((f) => f.id == targetId);
    target.hp = (target.hp - actor.attackDamage).clamp(0, target.maxHp);

    onAction(actorId, targetId, actor.attackDamage);

    if (playerWon) {
      onBattleEnd(true);
      return;
    }
    if (playerLost) {
      onBattleEnd(false);
      return;
    }

    _nextTurn();
  }

  void _nextTurn() {
    do {
      currentTurnIndex = (currentTurnIndex + 1) % fighters.length;
    } while (!currentFighter.isAlive);

    if (!currentFighter.isPlayer) {
      Future.delayed(const Duration(milliseconds: 600), _enemyTurn);
    }
  }

  void _enemyTurn() {
    final target = fighters.firstWhere((f) => f.isPlayer && f.isAlive);
    _resolveAttack(currentFighter.id, target.id);
  }
}
