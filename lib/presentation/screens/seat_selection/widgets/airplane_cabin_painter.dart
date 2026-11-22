import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';

/// Renders the sleek airplane fuselage silhouette, wings, and cockpit nose
class AirplaneCabinPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final fuselagePaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    final outlinePaint = Paint()
      ..color = AppColors.borderLight
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;

    final wingPaint = Paint()
      ..color = AppColors.surfaceSoft.withValues(alpha: 0.6)
      ..style = PaintingStyle.fill;

    // Cockpit nose (curved dome at top)
    final path = Path();
    path.moveTo(size.width * 0.2, 80);
    path.quadraticBezierTo(size.width * 0.5, 0, size.width * 0.8, 80);
    path.lineTo(size.width * 0.9, size.height);
    path.lineTo(size.width * 0.1, size.height);
    path.close();

    // Subtle wing left & right
    final leftWing = Path();
    leftWing.moveTo(size.width * 0.1, size.height * 0.40);
    leftWing.lineTo(-20, size.height * 0.55);
    leftWing.lineTo(size.width * 0.1, size.height * 0.65);
    leftWing.close();

    final rightWing = Path();
    rightWing.moveTo(size.width * 0.9, size.height * 0.40);
    rightWing.lineTo(size.width + 20, size.height * 0.55);
    rightWing.lineTo(size.width * 0.9, size.height * 0.65);
    rightWing.close();

    canvas.drawPath(leftWing, wingPaint);
    canvas.drawPath(rightWing, wingPaint);

    canvas.drawPath(path, fuselagePaint);
    canvas.drawPath(path, outlinePaint);

    // Cockpit windows
    final cockpitPaint = Paint()
      ..color = AppColors.midnight.withValues(alpha: 0.12)
      ..style = PaintingStyle.fill;

    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromCenter(center: Offset(size.width * 0.42, 50), width: 22, height: 12),
        const Radius.circular(4),
      ),
      cockpitPaint,
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromCenter(center: Offset(size.width * 0.58, 50), width: 22, height: 12),
        const Radius.circular(4),
      ),
      cockpitPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldPainter) => false;
}
