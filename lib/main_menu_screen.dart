import 'package:flutter/material.dart';
import 'save_data.dart';
import 'save_service.dart';
import 'game_screen.dart';
import 'customize_screen.dart';

class MainMenuScreen extends StatefulWidget {
  const MainMenuScreen({super.key});

  @override
  State<MainMenuScreen> createState() => _MainMenuScreenState();
}

class _MainMenuScreenState extends State<MainMenuScreen> {
  final _saveService = SaveService();
  bool _loading = true;
  bool _hasSave = false;

  @override
  void initState() {
    super.initState();
    _checkSave();
  }

  Future<void> _checkSave() async {
    final has = await _saveService.hasSave();
    setState(() {
      _hasSave = has;
      _loading = false;
    });
  }

  Future<void> _startNewGame() async {
    await _saveService.save(SaveData());
    if (!mounted) return;
    Navigator.of(context).push(MaterialPageRoute(builder: (_) => const GameScreen()));
  }

  void _continueGame() {
    Navigator.of(context).push(MaterialPageRoute(builder: (_) => const GameScreen()));
  }

  void _openCustomize() {
    Navigator.of(context).push(MaterialPageRoute(builder: (_) => const CustomizeScreen()));
  }

  void _comingSoon() {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Sắp ra mắt')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1a1a2e),
      body: Center(
        child: _loading
            ? const CircularProgressIndicator(color: Colors.white)
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('GAME RPG', style: TextStyle(fontFamily: 'PressStart2P', fontSize: 22, color: Colors.white)),
                  const SizedBox(height: 60),
                  if (_hasSave) _MenuButton(label: 'TIẾP TỤC', onTap: _continueGame),
                  if (_hasSave) const SizedBox(height: 16),
                  _MenuButton(label: 'CHƠI MỚI', onTap: _startNewGame),
                  const SizedBox(height: 16),
                  _MenuButton(label: 'TUỲ BIẾN', onTap: _openCustomize),
                  const SizedBox(height: 16),
                  _MenuButton(label: 'CÀI ĐẶT', onTap: _comingSoon),
                ],
              ),
      ),
    );
  }
}

class _MenuButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;

  const _MenuButton({required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 220,
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(color: const Color(0xFF0f3460), border: Border.all(color: Colors.white, width: 3)),
        alignment: Alignment.center,
        child: Text(label, style: const TextStyle(fontFamily: 'PressStart2P', fontSize: 12, color: Colors.white)),
      ),
    );
  }
}
