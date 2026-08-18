class SaveData {
  String playerName;
  String characterPreset;
  int gold;

  SaveData({
    this.playerName = '',
    this.characterPreset = 'preset_1',
    this.gold = 0,
  });

  Map<String, dynamic> toJson() => {
        'playerName': playerName,
        'characterPreset': characterPreset,
        'gold': gold,
      };

  factory SaveData.fromJson(Map<String, dynamic> json) => SaveData(
        playerName: json['playerName'] as String? ?? '',
        characterPreset: json['characterPreset'] as String? ?? 'preset_1',
        gold: json['gold'] as int? ?? 0,
      );
}
