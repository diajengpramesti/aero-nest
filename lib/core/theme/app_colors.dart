import 'package:flutter/material.dart';

class AppColors {
  // Pastel Orange / Peach Sherbet Hero Palette
  static const Color orangePrimary = Color(0xFFFF7A45);
  static const Color orangePastel = Color(0xFFFF9E6C);
  static const Color orangeLight = Color(0xFFFFB68C);
  static const Color orangeCream = Color(0xFFFFF1E8);
  static const Color orangeSubtle = Color(0xFFFFF8F4);
  static const Color orangeGlow = Color(0x40FF7A45);

  // Modern Gen-Z Contrasts: Midnight Celestial Slate
  static const Color midnight = Color(0xFF14132A);
  static const Color midnightLighter = Color(0xFF22203E);
  static const Color slateCard = Color(0xFF2E2B4E);
  static const Color slateMuted = Color(0xFF6B6888);
  static const Color slateLight = Color(0xFF9E9BAC);

  // Accent & Highlight Tones
  static const Color lilacAccent = Color(0xFF7E72F2);
  static const Color lilacSoft = Color(0xFFECEAFE);
  static const Color mintSuccess = Color(0xFF10B981);
  static const Color mintSoft = Color(0xFFD1FAE5);
  static const Color coralAlert = Color(0xFFEF4444);
  static const Color skyBlue = Color(0xFF38BDF8);
  static const Color skyBlueSoft = Color(0xFFE0F2FE);

  // Neutral Canvas & Surface
  static const Color background = Color(0xFFF7F8FC);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color surfaceSoft = Color(0xFFF2F4FA);
  static const Color borderLight = Color(0xFFE8ECF4);
  static const Color darkBorder = Color(0xFF2E2B4E);

  // Frosted Glass Gradients
  static const LinearGradient sunsetOrangeGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFFFF8A59),
      Color(0xFFFF6433),
    ],
  );

  static const LinearGradient softOrangeGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFFFFF0E6),
      Color(0xFFFFDFCE),
    ],
  );

  static const LinearGradient glassGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xB3FFFFFF),
      Color(0x66FFFFFF),
    ],
  );

  static const LinearGradient darkGlassGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xCC201D38),
      Color(0x9917152B),
    ],
  );

  static const LinearGradient holographicBadgeGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFFFF9E6C),
      Color(0xFF8E8CD8),
      Color(0xFF6EE7B7),
    ],
  );
}
