import 'package:flutter/material.dart';

/// Realistically styled custom Barcode Painter for flight boarding pass
class BarcodePainter extends CustomPainter {
  final Color color;
  final String seed;

  BarcodePainter({
    this.color = const Color(0xFF1E1B4B),
    this.seed = 'GA-821-2026-X99',
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeCap = StrokeCap.square;

    final widths = [
      1.5, 3.0, 1.0, 4.0, 2.0, 1.0, 3.5, 1.5, 2.5, 1.0, 4.0, 1.5,
      2.0, 3.0, 1.0, 2.0, 4.0, 1.5, 2.5, 3.5, 1.0, 2.0, 3.0, 1.5,
      4.0, 2.0, 1.5, 3.0, 1.0, 2.5, 3.5, 1.5, 4.0, 2.0, 1.0, 3.0
    ];

    double currentX = 0;
    int index = 0;

    while (currentX < size.width) {
      final w = widths[index % widths.length];
      final isBlack = (index % 2 == 0);

      if (isBlack) {
        paint.strokeWidth = w;
        canvas.drawLine(
          Offset(currentX + w / 2, 0),
          Offset(currentX + w / 2, size.height),
          paint,
        );
      }
      currentX += w + 1.2;
      index++;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldPainter) => false;
}
