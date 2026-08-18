import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'save_data.dart';

class SaveService {
  static const _key = 'save_data';

  Future<SaveData?> load() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_key);
    if (raw == null) return null;
    return SaveData.fromJson(jsonDecode(raw) as Map<String, dynamic>);
  }

  Future<void> save(SaveData data) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_key, jsonEncode(data.toJson()));
  }

  Future<bool> hasSave() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.containsKey(_key);
  }

  Future<void> clear() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_key);
  }
}
