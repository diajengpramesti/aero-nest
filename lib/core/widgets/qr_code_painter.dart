import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

/// High-tech QR Code Visual Custom Painter with stylish rounded corners and center flight badge
class QRCodePainter extends CustomPainter {
  final Color primaryColor;

  QRCodePainter({
    this.primaryColor = AppColors.midnight,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = primaryColor
      ..style = PaintingStyle.fill;

    const int matrixSize = 17;
    final double cellSize = size.width / matrixSize;

    // Pseudo-random deterministic QR grid representation
    final qrPattern = [
      '11111110101111111',
      '10000010011000001',
      '10111010101011101',
      '10111010001011101',
      '10111010111011101',
      '10000010101000001',
      '11111110101111111',
      '00000000010000000',
      '10101101011011010',
      '01010010100100101',
      '11111110110101010',
      '10000010001011101',
      '10111010101010001',
      '10111010110101101',
      '10111010011011111',
      '10000010101001010',
      '11111110111101011',
    ];

    for (int r = 0; r < matrixSize; r++) {
      for (int c = 0; c < matrixSize; c++) {
        if (qrPattern[r][c] == '1') {
          // Check if within corners or normal dots
          final isCorner = (r < 7 && c < 7) ||
              (r < 7 && c >= matrixSize - 7) ||
              (r >= matrixSize - 7 && c < 7);

          final rect = Rect.fromLTWH(
            c * cellSize + 0.8,
            r * cellSize + 0.8,
            cellSize - 1.6,
            cellSize - 1.6,
          );

          final rrect = RRect.fromRectAndRadius(
            rect,
            Radius.circular(isCorner ? 2.5 : 1.5),
          );
          canvas.drawRRect(rrect, paint);
        }
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldPainter) => false;
}
