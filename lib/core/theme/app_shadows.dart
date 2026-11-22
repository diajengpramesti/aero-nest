import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppShadows {
  // 3D Soft-Realism tactile elevation: Upper highlight + soft ambient depth
  static List<BoxShadow> soft3D({
    Color shadowColor = const Color(0x1A281E15),
    double elevation = 8,
    double blurRadius = 24,
    Offset offset = const Offset(0, 8),
  }) {
    return [
      BoxShadow(
        color: shadowColor,
        blurRadius: blurRadius,
        spreadRadius: -2,
        offset: offset,
      ),
      const BoxShadow(
        color: Color(0x80FFFFFF),
        blurRadius: 12,
        spreadRadius: 1,
        offset: Offset(0, -2),
      ),
    ];
  }

  // Floating Hero Button Glow
  static List<BoxShadow> orangeGlow = [
    BoxShadow(
      color: AppColors.orangePrimary.withValues(alpha: 0.38),
      blurRadius: 22,
      spreadRadius: 2,
      offset: const Offset(0, 10),
    ),
    const BoxShadow(
      color: Color(0x55FFAE85),
      blurRadius: 10,
      spreadRadius: 0,
      offset: Offset(0, 2),
    ),
  ];

  // Glassy Card Ambient Glow
  static List<BoxShadow> glassSoft = [
    BoxShadow(
      color: const Color(0xFF1E1B4B).withValues(alpha: 0.06),
      blurRadius: 24,
      spreadRadius: 0,
      offset: const Offset(0, 8),
    ),
    BoxShadow(
      color: Colors.white.withValues(alpha: 0.9),
      blurRadius: 10,
      spreadRadius: 0,
      offset: const Offset(0, -3),
    ),
  ];

  // Recessed Inset Effect for toggles and text inputs
  static List<BoxShadow> recessed3D = [
    BoxShadow(
      color: const Color(0x1A0F172A),
      blurRadius: 6,
      spreadRadius: 0,
      offset: const Offset(0, 2),
    ),
  ];
}
