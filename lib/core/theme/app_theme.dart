import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'app_typography.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      scaffoldBackgroundColor: AppColors.background,
      primaryColor: AppColors.orangePrimary,
      cardColor: Colors.white,
      dividerColor: AppColors.borderLight,
      colorScheme: const ColorScheme.light(
        primary: AppColors.orangePrimary,
        secondary: AppColors.lilacAccent,
        surface: AppColors.surface,
        error: AppColors.coralAlert,
      ),
      textTheme: TextTheme(
        displayLarge: AppTypography.displayLarge,
        displayMedium: AppTypography.displayMedium,
        titleLarge: AppTypography.headingLarge,
        titleMedium: AppTypography.headingMedium,
        bodyLarge: AppTypography.bodyLarge,
        bodyMedium: AppTypography.bodyMedium,
        bodySmall: AppTypography.bodySmall,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        iconTheme: IconThemeData(color: AppColors.midnight),
      ),
    );
  }

  static ThemeData get darkTheme {
    const darkBg = Color(0xFF0C0B18);
    const darkSurface = Color(0xFF16152B);
    const darkCard = Color(0xFF1C1A36);
    const darkBorder = Color(0xFF29274C);

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: darkBg,
      primaryColor: AppColors.orangePrimary,
      cardColor: darkCard,
      dividerColor: darkBorder,
      colorScheme: const ColorScheme.dark(
        primary: AppColors.orangePrimary,
        secondary: AppColors.lilacAccent,
        surface: darkSurface,
        error: AppColors.coralAlert,
      ),
      textTheme: TextTheme(
        displayLarge: AppTypography.displayLarge.copyWith(color: Colors.white),
        displayMedium: AppTypography.displayMedium.copyWith(color: Colors.white),
        titleLarge: AppTypography.headingLarge.copyWith(color: Colors.white),
        titleMedium: AppTypography.headingMedium.copyWith(color: Colors.white),
        bodyLarge: AppTypography.bodyLarge.copyWith(color: const Color(0xFFE2E4F0)),
        bodyMedium: AppTypography.bodyMedium.copyWith(color: const Color(0xFF9E9BAC)),
        bodySmall: AppTypography.bodySmall.copyWith(color: const Color(0xFF7A7790)),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        iconTheme: IconThemeData(color: Colors.white),
      ),
    );
  }
}
