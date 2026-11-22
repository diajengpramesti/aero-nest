import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

class AppTypography {
  static const List<String> _fallback = [
    'Plus Jakarta Sans',
    'Segoe UI',
    'Roboto',
    'Helvetica Neue',
    'Arial',
    'sans-serif',
  ];

  static TextStyle _font({
    required double size,
    required FontWeight weight,
    required Color color,
    double? letterSpacing,
    double? height,
    bool isDisplay = false,
    bool isMono = false,
  }) {
    try {
      if (isMono) {
        return GoogleFonts.spaceMono(
          fontSize: size,
          fontWeight: weight,
          color: color,
          letterSpacing: letterSpacing,
          height: height,
        );
      }
      if (isDisplay) {
        return GoogleFonts.outfit(
          fontSize: size,
          fontWeight: weight,
          color: color,
          letterSpacing: letterSpacing,
          height: height,
        );
      }
      return GoogleFonts.plusJakartaSans(
        fontSize: size,
        fontWeight: weight,
        color: color,
        letterSpacing: letterSpacing,
        height: height,
      );
    } catch (_) {
      // Offline / Web fallback
      return TextStyle(
        fontFamilyFallback: _fallback,
        fontSize: size,
        fontWeight: weight,
        color: color,
        letterSpacing: letterSpacing,
        height: height,
      );
    }
  }

  static TextStyle get displayLarge => _font(
        size: 32,
        weight: FontWeight.w800,
        color: AppColors.midnight,
        letterSpacing: -0.8,
        height: 1.15,
        isDisplay: true,
      );

  static TextStyle get displayMedium => _font(
        size: 26,
        weight: FontWeight.w700,
        color: AppColors.midnight,
        letterSpacing: -0.5,
        isDisplay: true,
      );

  static TextStyle get headingLarge => _font(
        size: 20,
        weight: FontWeight.w700,
        color: AppColors.midnight,
        letterSpacing: -0.3,
      );

  static TextStyle get headingMedium => _font(
        size: 17,
        weight: FontWeight.w600,
        color: AppColors.midnight,
        letterSpacing: -0.2,
      );

  static TextStyle get bodyLarge => _font(
        size: 15,
        weight: FontWeight.w500,
        color: AppColors.midnight,
        height: 1.4,
      );

  static TextStyle get bodyMedium => _font(
        size: 13,
        weight: FontWeight.w400,
        color: AppColors.slateMuted,
        height: 1.4,
      );

  static TextStyle get bodySmall => _font(
        size: 11,
        weight: FontWeight.w500,
        color: AppColors.slateLight,
      );

  static TextStyle get monoAirportCode => _font(
        size: 28,
        weight: FontWeight.w700,
        color: AppColors.midnight,
        letterSpacing: 1.2,
        isMono: true,
      );

  static TextStyle get labelGenZ => _font(
        size: 12,
        weight: FontWeight.w700,
        color: AppColors.midnight,
        letterSpacing: 0.5,
      );
}
