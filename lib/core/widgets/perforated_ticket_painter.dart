import 'package:flutter/material.dart';

/// Custom Painter that creates realistic boarding pass ticket notches
/// and a dashed perforation fold line
class PerforatedTicketClipper extends CustomClipper<Path> {
  final double punchRadius;
  final double punchPositionFraction; // Vertical fraction where notch appears (e.g. 0.68)

  PerforatedTicketClipper({
    this.punchRadius = 14.0,
    this.punchPositionFraction = 0.68,
  });

  @override
  Path getClip(Size size) {
    final path = Path();
    final notchY = size.height * punchPositionFraction;

    // Top-left start
    path.lineTo(size.width, 0);

    // Right side notch
    path.lineTo(size.width, notchY - punchRadius);
    path.arcToPoint(
      Offset(size.width, notchY + punchRadius),
      radius: Radius.circular(punchRadius),
      clockwise: false,
    );
    path.lineTo(size.width, size.height);

    // Bottom side
    path.lineTo(0, size.height);

    // Left side notch
    path.lineTo(0, notchY + punchRadius);
    path.arcToPoint(
      Offset(0, notchY - punchRadius),
      radius: Radius.circular(punchRadius),
      clockwise: false,
    );
    path.lineTo(0, 0);

    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => true;
}

/// Dashed line divider across the boarding pass perforation
class PerforationDividerPainter extends CustomPainter {
  final Color color;
  final double dashWidth;
  final double dashSpace;

  PerforationDividerPainter({
    this.color = const Color(0xFFD4D8E3),
    this.dashWidth = 6.0,
    this.dashSpace = 4.0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 1.5
      ..strokeCap = StrokeCap.round;

    double startX = 14.0;
    final endX = size.width - 14.0;

    while (startX < endX) {
      canvas.drawLine(
        Offset(startX, size.height / 2),
        Offset(startX + dashWidth, size.height / 2),
        paint,
      );
      startX += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldPainter) => false;
}
