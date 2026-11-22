import 'package:flutter/material.dart';
import '../../core/localization/app_locale.dart';
import '../../core/localization/locale_controller.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';
import '../../core/widgets/interactive_scale_button.dart';

class LanguageSelectorSheet extends StatelessWidget {
  final LocaleController localeController;

  const LanguageSelectorSheet({
    super.key,
    required this.localeController,
  });

  static void show(BuildContext context, LocaleController localeController) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (ctx) => LanguageSelectorSheet(localeController: localeController),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final cardBg = isDark ? const Color(0xFF16152B) : Colors.white;

    return Container(
      decoration: BoxDecoration(
        color: cardBg,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
        border: Border.all(
          color: isDark ? const Color(0xFF29274C) : AppColors.borderLight,
        ),
      ),
      padding: const EdgeInsets.fromLTRB(24, 16, 24, 32),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Center(
            child: Container(
              width: 44,
              height: 4,
              decoration: BoxDecoration(
                color: isDark ? const Color(0xFF323055) : AppColors.borderLight,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          const SizedBox(height: 18),

          Row(
            children: [
              const Icon(Icons.language_rounded, color: AppColors.orangePrimary, size: 24),
              const SizedBox(width: 10),
              Text(
                localeController.t('language'),
                style: AppTypography.headingLarge.copyWith(
                  color: isDark ? Colors.white : AppColors.midnight,
                  fontSize: 18,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          ...AppLanguage.values.map((lang) {
            final isSelected = localeController.currentLanguage == lang;

            return Container(
              margin: const EdgeInsets.only(bottom: 10),
              child: InteractiveScaleButton(
                onPressed: () {
                  localeController.setLanguage(lang);
                  Navigator.pop(context);
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? (isDark ? const Color(0xFF282346) : AppColors.orangeCream)
                        : (isDark ? const Color(0xFF1C1A36) : AppColors.surfaceSoft),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: isSelected
                          ? AppColors.orangePrimary
                          : (isDark ? const Color(0xFF2B294F) : AppColors.borderLight),
                      width: isSelected ? 1.5 : 1,
                    ),
                  ),
                  child: Row(
                    children: [
                      Text(
                        AppLocale.getLanguageLabel(lang),
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: isSelected ? FontWeight.w800 : FontWeight.w600,
                          color: isSelected
                              ? AppColors.orangePrimary
                              : (isDark ? Colors.white : AppColors.midnight),
                        ),
                      ),
                      const Spacer(),
                      if (isSelected)
                        Container(
                          padding: const EdgeInsets.all(4),
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.orangePrimary,
                          ),
                          child: const Icon(
                            Icons.check_rounded,
                            size: 14,
                            color: Colors.white,
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}
