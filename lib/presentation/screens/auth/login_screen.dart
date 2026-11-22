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
import '../../widgets/language_selector_sheet.dart';
import 'register_screen.dart';

class LoginScreen extends StatefulWidget {
  final AuthController authController;
  final LocaleController localeController;
  final ThemeController themeController;
  final VoidCallback onLoginSuccess;

  const LoginScreen({
    super.key,
    required this.authController,
    required this.localeController,
    required this.themeController,
    required this.onLoginSuccess,
  });

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController(text: 'ajeng@aeronest.io');
  final _passwordController = TextEditingController(text: 'secret123');
  bool _obscurePassword = true;
  bool _showGuide = true; // Displayed by default for complete onboarding guidance
  String? _errorMessage;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _handleGuestLogin() {
    widget.authController.loginAsGuest();
    widget.onLoginSuccess();
  }

  void _handleLogin() {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    if (email.isEmpty) {
      setState(() => _errorMessage = 'Email tidak boleh kosong');
      return;
    }
    if (password.length < 6) {
      setState(() => _errorMessage = 'Kata sandi minimal 6 karakter');
      return;
    }

    final success = widget.authController.login(email: email, password: password);
    if (success) {
      widget.onLoginSuccess();
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = widget.themeController.isDarkMode;
    final t = widget.localeController.t;

    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF0C0B18) : AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Top Bar: Theme toggle & Language pill
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Dark / Light Mode Switcher
                  InteractiveScaleButton(
                    onPressed: () => widget.themeController.toggleTheme(),
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: isDark ? const Color(0xFF1C1A36) : Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: isDark ? const Color(0xFF2C2A52) : AppColors.borderLight,
                        ),
                        boxShadow: AppShadows.soft3D(elevation: 4, blurRadius: 10),
                      ),
                      child: Icon(
                        isDark ? Icons.light_mode_rounded : Icons.dark_mode_rounded,
                        color: isDark ? const Color(0xFFFFB68C) : AppColors.midnight,
                        size: 20,
                      ),
                    ),
                  ),

                  // Language Switcher Dropdown Pill
                  InteractiveScaleButton(
                    onPressed: () => LanguageSelectorSheet.show(context, widget.localeController),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                      decoration: BoxDecoration(
                        color: isDark ? const Color(0xFF1C1A36) : Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: isDark ? const Color(0xFF2C2A52) : AppColors.borderLight,
                        ),
                        boxShadow: AppShadows.soft3D(elevation: 4, blurRadius: 10),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.language_rounded, size: 16, color: AppColors.orangePrimary),
                          const SizedBox(width: 6),
                          Text(
                            AppLocale.getLanguageShort(widget.localeController.currentLanguage),
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w800,
                              color: isDark ? Colors.white : AppColors.midnight,
                            ),
                          ),
                          const SizedBox(width: 4),
                          Icon(Icons.keyboard_arrow_down_rounded,
                              size: 16, color: isDark ? Colors.white70 : AppColors.slateMuted),
                        ],
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 28),

              // 3D Soft Realism Aircraft Emblem
              Center(
                child: Container(
                  width: 76,
                  height: 76,
                  decoration: BoxDecoration(
                    gradient: AppColors.sunsetOrangeGradient,
                    shape: BoxShape.circle,
                    boxShadow: AppShadows.orangeGlow,
                    border: Border.all(color: Colors.white, width: 3),
                  ),
                  child: const Center(
                    child: Text('✈️', style: TextStyle(fontSize: 36)),
                  ),
                ),
              ),
              const SizedBox(height: 18),

              // Title & Subtitle
              Center(
                child: Text(
                  t('app_name'),
                  style: AppTypography.displayMedium.copyWith(
                    color: isDark ? Colors.white : AppColors.midnight,
                    fontWeight: FontWeight.w900,
                    letterSpacing: -0.5,
                  ),
                ),
              ),
              const SizedBox(height: 4),
              Center(
                child: Text(
                  t('tagline'),
                  textAlign: TextAlign.center,
                  style: AppTypography.bodySmall.copyWith(
                    color: isDark ? const Color(0xFF9E9BAC) : AppColors.slateMuted,
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Interactive Onboarding & Access Guide
              Container(
                decoration: BoxDecoration(
                  gradient: isDark
                      ? const LinearGradient(colors: [Color(0xFF221E40), Color(0xFF18162E)])
                      : const LinearGradient(colors: [Color(0xFFFFF6F0), Color(0xFFFFECE0)]),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: AppColors.orangePrimary.withValues(alpha: 0.3),
                    width: 1.5,
                  ),
                  boxShadow: AppShadows.soft3D(elevation: 2, blurRadius: 8),
                ),
                child: Column(
                  children: [
                    InkWell(
                      borderRadius: BorderRadius.circular(20),
                      onTap: () => setState(() => _showGuide = !_showGuide),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        child: Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(6),
                              decoration: BoxDecoration(
                                color: AppColors.orangePrimary.withValues(alpha: 0.15),
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(Icons.lightbulb_outline_rounded,
                                  color: AppColors.orangePrimary, size: 18),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                t('guide_title'),
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w800,
                                  color: isDark ? Colors.white : AppColors.midnight,
                                ),
                              ),
                            ),
                            Icon(
                              _showGuide ? Icons.keyboard_arrow_up_rounded : Icons.keyboard_arrow_down_rounded,
                              color: AppColors.orangePrimary,
                              size: 20,
                            ),
                          ],
                        ),
                      ),
                    ),
                    if (_showGuide) ...[
                      Padding(
                        padding: const EdgeInsets.fromLTRB(16, 0, 16, 14),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Divider(
                              height: 1,
                              color: AppColors.orangePrimary.withValues(alpha: 0.2),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              t('guide_member_perks'),
                              style: const TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w800,
                                color: AppColors.mintSuccess,
                              ),
                            ),
                            const SizedBox(height: 4),
                            _buildGuideBullet(
                              '👑 Diskon Selamat Datang Rp 250.000 dengan voucher AEROGENZ',
                              isDark,
                            ),
                            _buildGuideBullet(
                              '💾 E-Tiket & Boarding Pass tersimpan selamanya & bisa diunduh offline',
                              isDark,
                            ),
                            _buildGuideBullet(
                              '✈️ Akumulasi Poin AeroMiles & lencana penerbang Diamond',
                              isDark,
                            ),
                            const SizedBox(height: 10),
                            Text(
                              t('guide_guest_perks'),
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w800,
                                color: isDark ? const Color(0xFFFFB68C) : const Color(0xFFD97706),
                              ),
                            ),
                            const SizedBox(height: 4),
                            _buildGuideBullet(
                              '⚡ Akses instan tanpa registrasi untuk cek jadwal dan estimasi tiket',
                              isDark,
                            ),
                            _buildGuideBullet(
                              '⚠️ Peringatan: Riwayat pesanan & tiket sementara akan hilang jika cache dibersihkan',
                              isDark,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // 3D Login Card
              Soft3DCard(
                baseColor: isDark ? const Color(0xFF16152B) : Colors.white,
                border: Border.all(
                  color: isDark ? const Color(0xFF29274C) : Colors.white,
                  width: 1.5,
                ),
                padding: const EdgeInsets.all(22),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      t('welcome_back'),
                      style: AppTypography.headingLarge.copyWith(
                        color: isDark ? Colors.white : AppColors.midnight,
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      t('login_subtitle'),
                      style: AppTypography.bodySmall.copyWith(
                        color: isDark ? const Color(0xFF8A88A4) : AppColors.slateMuted,
                      ),
                    ),
                    const SizedBox(height: 20),

                    if (_errorMessage != null) ...[
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                        decoration: BoxDecoration(
                          color: AppColors.coralAlert.withValues(alpha: 0.12),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          _errorMessage!,
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: AppColors.coralAlert,
                          ),
                        ),
                      ),
                      const SizedBox(height: 14),
                    ],

                    // Email Field
                    _buildInputField(
                      label: t('email'),
                      hint: t('email_hint'),
                      controller: _emailController,
                      icon: Icons.alternate_email_rounded,
                      isDark: isDark,
                    ),
                    const SizedBox(height: 16),

                    // Password Field
                    _buildInputField(
                      label: t('password'),
                      hint: t('password_hint'),
                      controller: _passwordController,
                      icon: Icons.lock_outline_rounded,
                      isDark: isDark,
                      isPassword: true,
                      obscureText: _obscurePassword,
                      onToggleObscure: () {
                        setState(() => _obscurePassword = !_obscurePassword);
                      },
                    ),

                    const SizedBox(height: 10),

                    // Forgot Password
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {},
                        child: Text(
                          t('forgot_password'),
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            color: AppColors.orangePrimary,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 12),

                    // Login Button with Glow
                    InteractiveScaleButton(
                      onPressed: _handleLogin,
                      child: Container(
                        height: 52,
                        decoration: BoxDecoration(
                          gradient: AppColors.sunsetOrangeGradient,
                          borderRadius: BorderRadius.circular(26),
                          boxShadow: AppShadows.orangeGlow,
                        ),
                        alignment: Alignment.center,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              t('login'),
                              style: AppTypography.headingMedium.copyWith(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            const SizedBox(width: 8),
                            const Icon(Icons.arrow_forward_rounded, color: Colors.white, size: 18),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // Social logins
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    t('or_continue'),
                    style: TextStyle(
                      fontSize: 12,
                      color: isDark ? const Color(0xFF8A88A4) : AppColors.slateMuted,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 14),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildSocialBtn('G', 'Google', isDark),
                  const SizedBox(width: 16),
                  _buildSocialBtn('', 'Apple', isDark),
                ],
              ),

              const SizedBox(height: 32),

              // Switch to Register
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    t('dont_have_account'),
                    style: TextStyle(
                      fontSize: 13,
                      color: isDark ? const Color(0xFF9E9BAC) : AppColors.slateMuted,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (ctx) => RegisterScreen(
                            authController: widget.authController,
                            localeController: widget.localeController,
                            themeController: widget.themeController,
                            onRegisterSuccess: widget.onLoginSuccess,
                          ),
                        ),
                      );
                    },
                    child: Text(
                      t('signup_now'),
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w800,
                        color: AppColors.orangePrimary,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 24),

              // Or Continue as Guest Divider & Button
              Row(
                children: [
                  Expanded(
                    child: Divider(
                      color: isDark ? const Color(0xFF2E2B4E) : AppColors.borderLight,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Text(
                      'ATAU',
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 1.2,
                        color: isDark ? const Color(0xFF8A88A4) : AppColors.slateMuted,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Divider(
                      color: isDark ? const Color(0xFF2E2B4E) : AppColors.borderLight,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // 3D Soft-Realism Masuk sebagai Tamu Button
              InteractiveScaleButton(
                onPressed: _handleGuestLogin,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                  decoration: BoxDecoration(
                    color: isDark ? const Color(0xFF1E1C38) : Colors.white,
                    borderRadius: BorderRadius.circular(22),
                    border: Border.all(
                      color: isDark ? const Color(0xFF383562) : const Color(0xFFE2E7F0),
                      width: 1.5,
                    ),
                    boxShadow: AppShadows.soft3D(elevation: 3, blurRadius: 10),
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: isDark ? const Color(0xFF2B284E) : const Color(0xFFF1F3F9),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(
                          Icons.person_pin_circle_outlined,
                          color: AppColors.orangePrimary,
                          size: 22,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  t('guest_login_btn'),
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w800,
                                    color: isDark ? Colors.white : AppColors.midnight,
                                  ),
                                ),
                                const SizedBox(width: 6),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: AppColors.orangeCream,
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: Text(
                                    t('guest_badge'),
                                    style: const TextStyle(
                                      fontSize: 8,
                                      fontWeight: FontWeight.w900,
                                      color: AppColors.orangePrimary,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 2),
                            Text(
                              t('guest_login_sub'),
                              style: TextStyle(
                                fontSize: 10,
                                color: isDark ? const Color(0xFF9E9BAC) : AppColors.slateMuted,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Icon(
                        Icons.arrow_forward_ios_rounded,
                        size: 14,
                        color: isDark ? Colors.white60 : AppColors.slateLight,
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGuideBullet(String text, bool isDark) {
    return Padding(
      padding: const EdgeInsets.only(top: 3),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 10,
          height: 1.4,
          color: isDark ? const Color(0xFFC7C5DC) : const Color(0xFF4A4668),
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildInputField({
    required String label,
    required String hint,
    required TextEditingController controller,
    required IconData icon,
    required bool isDark,
    bool isPassword = false,
    bool obscureText = false,
    VoidCallback? onToggleObscure,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w700,
            color: isDark ? const Color(0xFFB4B2C8) : AppColors.slateMuted,
          ),
        ),
        const SizedBox(height: 6),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14),
          decoration: BoxDecoration(
            color: isDark ? const Color(0xFF22203E) : AppColors.surfaceSoft,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: isDark ? const Color(0xFF33305B) : AppColors.borderLight,
            ),
          ),
          child: TextField(
            controller: controller,
            obscureText: obscureText,
            style: TextStyle(
              fontSize: 14,
              color: isDark ? Colors.white : AppColors.midnight,
              fontWeight: FontWeight.w600,
            ),
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: TextStyle(
                fontSize: 13,
                color: isDark ? const Color(0xFF6B6888) : AppColors.slateLight,
              ),
              border: InputBorder.none,
              icon: Icon(
                icon,
                size: 18,
                color: isDark ? const Color(0xFF9E9BAC) : AppColors.slateMuted,
              ),
              suffixIcon: isPassword
                  ? IconButton(
                      icon: Icon(
                        obscureText ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                        size: 18,
                        color: isDark ? const Color(0xFF9E9BAC) : AppColors.slateMuted,
                      ),
                      onPressed: onToggleObscure,
                    )
                  : null,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSocialBtn(String glyph, String name, bool isDark) {
    return InteractiveScaleButton(
      onPressed: () {
        widget.authController.login(email: 'ajeng@google.com', password: 'social_pass');
        widget.onLoginSuccess();
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color: isDark ? const Color(0xFF1C1A36) : Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isDark ? const Color(0xFF2C2A52) : AppColors.borderLight,
          ),
          boxShadow: AppShadows.soft3D(elevation: 4, blurRadius: 10),
        ),
        child: Row(
          children: [
            Text(
              glyph,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w900,
                color: isDark ? Colors.white : AppColors.midnight,
              ),
            ),
            const SizedBox(width: 8),
            Text(
              name,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: isDark ? Colors.white : AppColors.midnight,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
