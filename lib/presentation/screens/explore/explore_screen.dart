import 'package:flutter/material.dart';
import '../../../core/localization/app_locale.dart';
import '../../../core/localization/locale_controller.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_shadows.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/theme/theme_controller.dart';
import '../../../core/widgets/interactive_scale_button.dart';
import '../../controllers/auth_controller.dart';
import '../../controllers/booking_controller.dart';
import '../../widgets/auth_prompt_sheet.dart';
import '../../widgets/language_selector_sheet.dart';
import 'widgets/search_flight_card.dart';
import 'widgets/date_passenger_picker_modal.dart';
import 'widgets/trending_destinations_carousel.dart';

class ExploreScreen extends StatelessWidget {
  final BookingController controller;
  final AuthController authController;
  final LocaleController localeController;
  final ThemeController themeController;
  final VoidCallback onNavigateToResults;
  final VoidCallback onOpenActivePass;

  const ExploreScreen({
    super.key,
    required this.controller,
    required this.authController,
    required this.localeController,
    required this.themeController,
    required this.onNavigateToResults,
    required this.onOpenActivePass,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = themeController.isDarkMode;
    final t = localeController.t;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(bottom: 120),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 12),

              // Header: Profile & Language & Theme Controls
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        // Avatar with soft 3D border
                        Container(
                          width: 48,
                          height: 48,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: authController.isGuest
                                ? const LinearGradient(colors: [Color(0xFFF59E0B), Color(0xFFD97706)])
                                : AppColors.sunsetOrangeGradient,
                            boxShadow: [
                              BoxShadow(
                                color: (authController.isGuest
                                        ? const Color(0xFFF59E0B)
                                        : AppColors.orangePrimary)
                                    .withValues(alpha: 0.35),
                                blurRadius: 12,
                                offset: const Offset(0, 4),
                              ),
                            ],
                            border: Border.all(color: Colors.white, width: 2),
                          ),
                          child: Center(
                            child: Text(
                              authController.isGuest ? '👤' : '✈️',
                              style: const TextStyle(fontSize: 22),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  authController.userName,
                                  style: AppTypography.headingMedium.copyWith(
                                    fontSize: 16,
                                    color: isDark ? Colors.white : AppColors.midnight,
                                  ),
                                ),
                                const SizedBox(width: 6),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: authController.isGuest
                                        ? (isDark ? const Color(0xFF382F18) : const Color(0xFFFEF3C7))
                                        : (isDark ? const Color(0xFF28254A) : AppColors.lilacSoft),
                                    borderRadius: BorderRadius.circular(8),
                                    border: authController.isGuest
                                        ? Border.all(
                                            color: const Color(0xFFF59E0B).withValues(alpha: 0.5),
                                            width: 1,
                                          )
                                        : null,
                                  ),
                                  child: Text(
                                    authController.isGuest ? t('guest_badge') : t('pro_badge'),
                                    style: TextStyle(
                                      fontSize: 9,
                                      fontWeight: FontWeight.w800,
                                      color: authController.isGuest
                                          ? const Color(0xFFD97706)
                                          : AppColors.lilacAccent,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              t('sub_greeting'),
                              style: AppTypography.bodySmall.copyWith(
                                color: isDark ? const Color(0xFF9E9BAC) : AppColors.slateMuted,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),

                    // Language Selector & Dark Mode Actions
                    Row(
                      children: [
                        // Language Pill
                        InteractiveScaleButton(
                          onPressed: () => LanguageSelectorSheet.show(context, localeController),
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                            decoration: BoxDecoration(
                              color: isDark ? const Color(0xFF1C1A36) : Colors.white,
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(
                                color: isDark ? const Color(0xFF2C2A52) : AppColors.borderLight,
                              ),
                              boxShadow: AppShadows.soft3D(elevation: 3, blurRadius: 8),
                            ),
                            child: Row(
                              children: [
                                const Icon(Icons.language_rounded, size: 14, color: AppColors.orangePrimary),
                                const SizedBox(width: 4),
                                Text(
                                  AppLocale.getLanguageShort(localeController.currentLanguage),
                                  style: TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w800,
                                    color: isDark ? Colors.white : AppColors.midnight,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),

                        // Theme Toggle Button
                        InteractiveScaleButton(
                          onPressed: () => themeController.toggleTheme(),
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: isDark ? const Color(0xFF1C1A36) : Colors.white,
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(
                                color: isDark ? const Color(0xFF2C2A52) : AppColors.borderLight,
                              ),
                              boxShadow: AppShadows.soft3D(elevation: 3, blurRadius: 8),
                            ),
                            child: Icon(
                              isDark ? Icons.light_mode_rounded : Icons.dark_mode_rounded,
                              color: isDark ? const Color(0xFFFFB68C) : AppColors.midnight,
                              size: 18,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // 3D Soft-Realism Guest Mode Notice Banner
              if (authController.isGuest)
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 16),
                  child: Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      gradient: isDark
                          ? const LinearGradient(colors: [Color(0xFF262040), Color(0xFF1B1734)])
                          : const LinearGradient(colors: [Color(0xFFFFF7ED), Color(0xFFFFEDD5)]),
                      borderRadius: BorderRadius.circular(22),
                      border: Border.all(
                        color: isDark ? const Color(0xFF4C3E75) : const Color(0xFFFDBA74),
                        width: 1.5,
                      ),
                      boxShadow: AppShadows.soft3D(elevation: 3, blurRadius: 10),
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: isDark ? const Color(0xFF382F5E) : const Color(0xFFFFEDD5),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(Icons.shield_outlined,
                              color: AppColors.orangePrimary, size: 22),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                t('guest_banner_title'),
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w800,
                                  color: isDark ? Colors.white : AppColors.midnight,
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                t('guest_banner_desc'),
                                style: TextStyle(
                                  fontSize: 10,
                                  color: isDark ? const Color(0xFFC4C2DD) : const Color(0xFF7C2D12),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 8),
                        InteractiveScaleButton(
                          onPressed: () {
                            AuthPromptSheet.show(
                              context,
                              authController: authController,
                              localeController: localeController,
                              themeController: themeController,
                            );
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                            decoration: BoxDecoration(
                              gradient: AppColors.sunsetOrangeGradient,
                              borderRadius: BorderRadius.circular(14),
                              boxShadow: AppShadows.orangeGlow,
                            ),
                            child: Text(
                              t('guest_upgrade_btn'),
                              style: const TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w800,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

              // Active Flight Boarding Alert (if booking exists)
              if (controller.myBookings.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: InteractiveScaleButton(
                    onPressed: onOpenActivePass,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: isDark
                              ? [const Color(0xFF1C1938), const Color(0xFF121026)]
                              : [const Color(0xFF201D38), const Color(0xFF14132A)],
                        ),
                        borderRadius: BorderRadius.circular(22),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFF14132A).withValues(alpha: 0.25),
                            blurRadius: 18,
                            offset: const Offset(0, 8),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: AppColors.orangePrimary.withValues(alpha: 0.2),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Icon(
                              Icons.flight_takeoff_rounded,
                              color: AppColors.orangePastel,
                              size: 20,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      width: 6,
                                      height: 6,
                                      decoration: const BoxDecoration(
                                        color: AppColors.mintSuccess,
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                    const SizedBox(width: 6),
                                    const Text(
                                      'BOARDING PASS SIAP',
                                      style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w800,
                                        color: AppColors.mintSuccess,
                                        letterSpacing: 0.8,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  '${controller.myBookings.first.flight.flightNumber} • Gate ${controller.myBookings.first.gate} • Kursi ${controller.myBookings.first.seat.code}',
                                  style: const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.12),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Row(
                              children: [
                                Text(
                                  'Lihat',
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                SizedBox(width: 4),
                                Icon(Icons.arrow_forward_ios_rounded,
                                    size: 10, color: Colors.white),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

              const SizedBox(height: 20),

              // Search Flight Card
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: SearchFlightCard(
                  controller: controller,
                  onSearch: onNavigateToResults,
                  onOpenDatePicker: () => DatePassengerPickerModal.show(
                    context,
                    controller: controller,
                    initialFocusDate: true,
                  ),
                  onOpenPassengerPicker: () => DatePassengerPickerModal.show(
                    context,
                    controller: controller,
                    initialFocusDate: false,
                  ),
                ),
              ),

              const SizedBox(height: 32),

              // Section Header: Trending Destinations
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          t('viral_destinations'),
                          style: AppTypography.headingLarge.copyWith(
                            fontSize: 18,
                            color: isDark ? Colors.white : AppColors.midnight,
                          ),
                        ),
                        Text(
                          t('viral_sub'),
                          style: AppTypography.bodySmall.copyWith(
                            color: isDark ? const Color(0xFF9E9BAC) : AppColors.slateMuted,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      t('see_all'),
                      style: AppTypography.bodySmall.copyWith(
                        color: AppColors.orangePrimary,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              // Trending Destinations Carousel
              TrendingDestinationsCarousel(
                controller: controller,
                onDestinationTapped: onNavigateToResults,
              ),

              const SizedBox(height: 28),

              // Section: Gen-Z Travel Perks Grid
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  'AeroNest Exclusive Perks 🚀',
                  style: AppTypography.headingLarge.copyWith(
                    fontSize: 17,
                    color: isDark ? Colors.white : AppColors.midnight,
                  ),
                ),
              ),
              const SizedBox(height: 14),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    _buildPerkCard(
                      icon: Icons.eco_rounded,
                      iconColor: AppColors.mintSuccess,
                      bg: AppColors.mintSoft,
                      title: t('perk_carbon'),
                      desc: t('perk_carbon_sub'),
                      isDark: isDark,
                    ),
                    const SizedBox(width: 12),
                    _buildPerkCard(
                      icon: Icons.bolt_rounded,
                      iconColor: AppColors.orangePrimary,
                      bg: AppColors.orangeCream,
                      title: t('perk_fast'),
                      desc: t('perk_fast_sub'),
                      isDark: isDark,
                    ),
                    const SizedBox(width: 12),
                    _buildPerkCard(
                      icon: Icons.wifi_rounded,
                      iconColor: AppColors.lilacAccent,
                      bg: AppColors.lilacSoft,
                      title: t('perk_wifi'),
                      desc: t('perk_wifi_sub'),
                      isDark: isDark,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPerkCard({
    required IconData icon,
    required Color iconColor,
    required Color bg,
    required String title,
    required String desc,
    required bool isDark,
  }) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: isDark ? const Color(0xFF16152B) : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isDark ? const Color(0xFF29274C) : AppColors.borderLight,
          ),
          boxShadow: AppShadows.soft3D(elevation: 4, blurRadius: 14),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: bg,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: iconColor, size: 20),
            ),
            const SizedBox(height: 10),
            Text(
              title,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w700,
                color: isDark ? Colors.white : AppColors.midnight,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              desc,
              style: TextStyle(
                fontSize: 10,
                color: isDark ? const Color(0xFF9E9BAC) : AppColors.slateMuted,
                height: 1.2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
