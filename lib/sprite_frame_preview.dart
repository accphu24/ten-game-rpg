import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SpriteFramePreview extends StatefulWidget {
  final String assetPath;
  final double size;

  const SpriteFramePreview({super.key, required this.assetPath, this.size = 96});

  @override
  State<SpriteFramePreview> createState() => _SpriteFramePreviewState();
}

class _SpriteFramePreviewState extends State<SpriteFramePreview> {
  ui.Image? _image;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final data = await rootBundle.load(widget.assetPath);
    final codec = await ui.instantiateImageCodec(data.buffer.asUint8List());
    final frame = await codec.getNextFrame();
    if (mounted) setState(() => _image = frame.image);
  }

  @override
  Widget build(BuildContext context) {
    if (_image == null) {
      return SizedBox(width: widget.size, height: widget.size);
    }
    return SizedBox(
      width: widget.size,
      height: widget.size,
      child: CustomPaint(painter: _FramePainter(_image!)),
    );
  }
}

class _FramePainter extends CustomPainter {
  final ui.Image image;
  _FramePainter(this.image);

  @override
  void paint(Canvas canvas, Size size) {
    // sheet 576x256, 9 cot x 4 hang, khung 64x64, hang "xuong" la index 2
    const frameW = 64.0;
    const frameH = 64.0;
    const row = 2;
    final src = Rect.fromLTWH(0, row * frameH, frameW, frameH);
    final dst = Rect.fromLTWH(0, 0, size.width, size.height);
    canvas.drawImageRect(image, src, dst, Paint()..filterQuality = FilterQuality.none);
  }

  @override
  bool shouldRepaint(covariant _FramePainter oldDelegate) => oldDelegate.image != image;
}
