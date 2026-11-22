import 'package:flutter/material.dart';
import '../../../core/localization/app_locale.dart';
import '../../../core/localization/locale_controller.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_shadows.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/theme/theme_controller.dart';
import '../../../core/widgets/interactive_scale_button.dart';
import '../../../core/widgets/soft_3d_card.dart';
import '../../controllers/auth_controller.dart';
import '../../widgets/auth_prompt_sheet.dart';
import '../../widgets/language_selector_sheet.dart';

class GenZPassportProfileScreen extends StatelessWidget {
  final AuthController authController;
  final LocaleController localeController;
  final ThemeController themeController;

  const GenZPassportProfileScreen({
    super.key,
    required this.authController,
    required this.localeController,
    required this.themeController,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = themeController.isDarkMode;
    final t = localeController.t;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 120),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                t('passport_title'),
                style: AppTypography.displayMedium.copyWith(
                  fontSize: 24,
                  color: isDark ? Colors.white : AppColors.midnight,
                ),
              ),
              Text(
                t('passport_sub'),
                style: AppTypography.bodySmall.copyWith(
                  color: isDark ? const Color(0xFF9E9BAC) : AppColors.slateMuted,
                ),
              ),
              const SizedBox(height: 20),

              // 3D Holographic Passport Card
              Container(
                padding: const EdgeInsets.all(22),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: authController.isGuest
                        ? (isDark
                            ? [const Color(0xFF282038), const Color(0xFF181426)]
                            : [const Color(0xFF322A48), const Color(0xFF1E1730)])
                        : (isDark
                            ? [const Color(0xFF1F1C3C), const Color(0xFF100F22)]
                            : [const Color(0xFF262347), const Color(0xFF14132A)]),
                  ),
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(
                    color: authController.isGuest
                        ? const Color(0xFFF59E0B).withValues(alpha: 0.4)
                        : Colors.white.withValues(alpha: 0.15),
                    width: authController.isGuest ? 2.0 : 1.5,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF14132A).withValues(alpha: 0.3),
                      blurRadius: 28,
                      offset: const Offset(0, 12),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (authController.isGuest) ...[
                      Row(
                        children: [
                          const Icon(Icons.info_outline_rounded, size: 14, color: Color(0xFFF59E0B)),
                          const SizedBox(width: 6),
                          Text(
                            t('guest_passport_title'),
                            style: const TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w800,
                              color: Color(0xFFF59E0B),
                              letterSpacing: 0.8,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                    ],
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                gradient: authController.isGuest
                                    ? const LinearGradient(colors: [Color(0xFFF59E0B), Color(0xFFD97706)])
                                    : AppColors.sunsetOrangeGradient,
                                border: Border.all(color: Colors.white, width: 2),
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                authController.isGuest ? '👤' : '🌟',
                                style: const TextStyle(fontSize: 24),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  authController.userName,
                                  style: const TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.w800,
                                    color: Colors.white,
                                  ),
                                ),
                                Text(
                                  authController.isGuest
                                      ? 'Mode Tamu (Belum Terverifikasi)'
                                      : authController.userEmail,
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: Colors.white.withValues(alpha: 0.7),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            gradient: authController.isGuest
                                ? const LinearGradient(colors: [Color(0xFFF59E0B), Color(0xFFD97706)])
                                : AppColors.holographicBadgeGradient,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            authController.isGuest ? t('guest_badge') : 'DIAMOND',
                            style: const TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w900,
                              color: Colors.white,
                              letterSpacing: 0.8,
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 28),

                    // Stats Row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildPassportStat(
                          t('miles_flown'),
                          authController.isGuest ? '0 mil (+1.200)' : '28.450 mil',
                        ),
                        _buildPassportStat(
                          t('countries'),
                          authController.isGuest ? '0' : '8',
                        ),
                        _buildPassportStat(
                          'STATUS',
                          authController.isGuest ? 'Lokal' : 'Cloud Sync',
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // 3D Soft-Realism Guest Upgrade Card
              if (authController.isGuest) ...[
                const SizedBox(height: 18),
                Container(
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    gradient: isDark
                        ? const LinearGradient(colors: [Color(0xFF262042), Color(0xFF1B1634)])
                        : const LinearGradient(colors: [Color(0xFFFFF7ED), Color(0xFFFFECE0)]),
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(
                      color: AppColors.orangePrimary.withValues(alpha: 0.35),
                      width: 1.5,
                    ),
                    boxShadow: AppShadows.soft3D(elevation: 4, blurRadius: 12),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: AppColors.orangePrimary.withValues(alpha: 0.15),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(Icons.rocket_launch_rounded,
                                color: AppColors.orangePrimary, size: 20),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              t('guest_upgrade_card_title'),
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w800,
                                color: isDark ? Colors.white : AppColors.midnight,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        t('guest_upgrade_card_desc'),
                        style: TextStyle(
                          fontSize: 11,
                          color: isDark ? const Color(0xFFC7C5DC) : const Color(0xFF6B6888),
                        ),
                      ),
                      const SizedBox(height: 14),
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
                          height: 46,
                          decoration: BoxDecoration(
                            gradient: AppColors.sunsetOrangeGradient,
                            borderRadius: BorderRadius.circular(23),
                            boxShadow: AppShadows.orangeGlow,
                          ),
                          alignment: Alignment.center,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                t('guest_upgrade_btn'),
                                style: const TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w800,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(width: 6),
                              const Icon(Icons.arrow_forward_rounded, color: Colors.white, size: 16),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],

              const SizedBox(height: 24),

              // Badges Section
              Text(
                t('traveler_badges'),
                style: AppTypography.bodySmall.copyWith(
                  color: isDark ? const Color(0xFFB4B2C8) : AppColors.slateMuted,
                ),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  _buildBadgePill('🏝️ Island Hopper', 'Bali & Lombok', isDark),
                  const SizedBox(width: 10),
                  _buildBadgePill('☁️ Cloud Sleeper', '10+ Flights', isDark),
                  const SizedBox(width: 10),
                  _buildBadgePill('☕ Coffee Hunter', '50+ Cafes', isDark),
                ],
              ),

              const SizedBox(height: 24),

              // Settings & Language & Theme Switchers
              Text(
                t('settings'),
                style: AppTypography.bodySmall.copyWith(
                  color: isDark ? const Color(0xFFB4B2C8) : AppColors.slateMuted,
                ),
              ),
              const SizedBox(height: 10),
              Soft3DCard(
                baseColor: isDark ? const Color(0xFF16152B) : Colors.white,
                border: Border.all(
                  color: isDark ? const Color(0xFF29274C) : AppColors.borderLight,
                ),
                padding: const EdgeInsets.all(8),
                child: Column(
                  children: [
                    // Language Selector Tile
                    ListTile(
                      leading: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: AppColors.orangeCream,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Icon(Icons.language_rounded, color: AppColors.orangePrimary, size: 20),
                      ),
                      title: Text(
                        t('language'),
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: isDark ? Colors.white : AppColors.midnight,
                        ),
                      ),
                      subtitle: Text(
                        AppLocale.getLanguageLabel(localeController.currentLanguage),
                        style: TextStyle(
                          fontSize: 11,
                          color: isDark ? const Color(0xFF9E9BAC) : AppColors.slateMuted,
                        ),
                      ),
                      trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 12, color: AppColors.slateLight),
                      onTap: () => LanguageSelectorSheet.show(context, localeController),
                      dense: true,
                    ),
                    Divider(height: 1, color: isDark ? const Color(0xFF29274C) : AppColors.borderLight),

                    // Dark / Light Mode Switcher Tile
                    ListTile(
                      leading: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: isDark ? const Color(0xFF2E2B4E) : AppColors.lilacSoft,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Icon(
                          isDark ? Icons.light_mode_rounded : Icons.dark_mode_rounded,
                          color: isDark ? const Color(0xFFFFB68C) : AppColors.lilacAccent,
                          size: 20,
                        ),
                      ),
                      title: Text(
                        t('theme_mode'),
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: isDark ? Colors.white : AppColors.midnight,
                        ),
                      ),
                      subtitle: Text(
                        isDark ? t('dark_mode') : t('light_mode'),
                        style: TextStyle(
                          fontSize: 11,
                          color: isDark ? const Color(0xFF9E9BAC) : AppColors.slateMuted,
                        ),
                      ),
                      trailing: Switch(
                        value: isDark,
                        activeThumbColor: AppColors.orangePrimary,
                        onChanged: (val) => themeController.toggleTheme(),
                      ),
                      dense: true,
                    ),
                    Divider(height: 1, color: isDark ? const Color(0xFF29274C) : AppColors.borderLight),

                    // Logout / Exit Guest Tile
                    ListTile(
                      leading: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: (authController.isGuest ? AppColors.orangePrimary : AppColors.coralAlert)
                              .withValues(alpha: 0.12),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Icon(
                          authController.isGuest ? Icons.login_rounded : Icons.logout_rounded,
                          color: authController.isGuest ? AppColors.orangePrimary : AppColors.coralAlert,
                          size: 20,
                        ),
                      ),
                      title: Text(
                        authController.isGuest ? 'Keluar Mode Tamu (Login / Daftar)' : t('logout'),
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: authController.isGuest ? AppColors.orangePrimary : AppColors.coralAlert,
                        ),
                      ),
                      subtitle: authController.isGuest
                          ? Text(
                              'Masuk ke akunmu untuk simpan riwayat & tiket',
                              style: TextStyle(
                                fontSize: 11,
                                color: isDark ? const Color(0xFF9E9BAC) : AppColors.slateMuted,
                              ),
                            )
                          : null,
                      onTap: () => authController.logout(),
                      dense: true,
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

  Widget _buildPassportStat(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 9, color: Colors.white60, fontWeight: FontWeight.w700)),
        const SizedBox(height: 2),
        Text(value, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w800, color: Colors.white)),
      ],
    );
  }

  Widget _buildBadgePill(String title, String desc, bool isDark) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isDark ? const Color(0xFF16152B) : Colors.white,
          borderRadius: BorderRadius.circular(18),
          boxShadow: AppShadows.soft3D(elevation: 3, blurRadius: 8),
          border: Border.all(
            color: isDark ? const Color(0xFF29274C) : AppColors.borderLight,
          ),
        ),
        child: Column(
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w700,
                color: isDark ? Colors.white : AppColors.midnight,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 2),
            Text(
              desc,
              style: TextStyle(
                fontSize: 9,
                color: isDark ? const Color(0xFF8A88A4) : AppColors.slateMuted,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
