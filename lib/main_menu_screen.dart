import 'package:flutter/material.dart';
import 'save_data.dart';
import 'save_service.dart';
import 'game_screen.dart';
import 'customize_screen.dart';
import 'pixel_button.dart';

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
                  if (_hasSave) PixelButton(label: 'TIẾP TỤC', onTap: _continueGame),
                  if (_hasSave) const SizedBox(height: 16),
                  PixelButton(label: 'CHƠI MỚI', onTap: _startNewGame),
                  const SizedBox(height: 16),
                  PixelButton(label: 'TUỲ BIẾN', onTap: _openCustomize),
                  const SizedBox(height: 16),
                  PixelButton(label: 'CÀI ĐẶT', onTap: _comingSoon),
                ],
              ),
      ),
    );
  }
}
