import 'package:flutter/material.dart';
import 'save_data.dart';
import 'save_service.dart';
import 'sprite_frame_preview.dart';

class CustomizeScreen extends StatefulWidget {
  const CustomizeScreen({super.key});

  @override
  State<CustomizeScreen> createState() => _CustomizeScreenState();
}

class _CustomizeScreenState extends State<CustomizeScreen> {
  final _saveService = SaveService();
  String _selected = 'preset_1';
  bool _loading = true;

  static const _presets = ['preset_1', 'preset_2', 'preset_3', 'preset_4'];

  @override
  void initState() {
    super.initState();
    _loadCurrent();
  }

  Future<void> _loadCurrent() async {
    final data = await _saveService.load();
    setState(() {
      _selected = data?.characterPreset ?? 'preset_1';
      _loading = false;
    });
  }

  Future<void> _choose(String preset) async {
    setState(() => _selected = preset);
    final data = await _saveService.load() ?? SaveData();
    data.characterPreset = preset;
    await _saveService.save(data);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1a1a2e),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1a1a2e),
        title: const Text('TUỲ BIẾN', style: TextStyle(fontFamily: 'PressStart2P', fontSize: 12, color: Colors.white)),
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator(color: Colors.white))
          : Center(
              child: Wrap(
                spacing: 20,
                runSpacing: 20,
                alignment: WrapAlignment.center,
                children: _presets.map((p) {
                  final isSelected = p == _selected;
                  return GestureDetector(
                    onTap: () => _choose(p),
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: const Color(0xFF0f3460),
                        border: Border.all(color: isSelected ? Colors.yellow : Colors.white24, width: isSelected ? 4 : 2),
                      ),
                      child: SpriteFramePreview(assetPath: 'assets/images/characters/$p.png', size: 96),
                    ),
                  );
                }).toList(),
              ),
            ),
    );
  }
}
