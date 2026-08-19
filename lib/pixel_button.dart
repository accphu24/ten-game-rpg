import 'package:flutter/material.dart';

class PixelButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  final bool selected;
  final double width;

  const PixelButton({
    super.key,
    required this.label,
    required this.onTap,
    this.selected = false,
    this.width = 220,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        height: 56,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              selected
                  ? 'assets/images/ui/button_selected.png'
                  : 'assets/images/ui/button_normal.png',
            ),
            centerSlice: const Rect.fromLTRB(8, 8, 40, 40),
            filterQuality: FilterQuality.none,
          ),
        ),
        alignment: Alignment.center,
        child: Text(
          label,
          style: const TextStyle(fontFamily: 'PressStart2P', fontSize: 12, color: Colors.white),
        ),
      ),
    );
  }
}
