import 'package:flutter/material.dart';
import '../../../core/localization/locale_controller.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_shadows.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/theme/theme_controller.dart';
import '../../../core/widgets/interactive_scale_button.dart';
import '../../../core/widgets/soft_3d_card.dart';
import '../../controllers/auth_controller.dart';

class RegisterScreen extends StatefulWidget {
  final AuthController authController;
  final LocaleController localeController;
  final ThemeController themeController;
  final VoidCallback onRegisterSuccess;

  const RegisterScreen({
    super.key,
    required this.authController,
    required this.localeController,
    required this.themeController,
    required this.onRegisterSuccess,
  });

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _obscurePassword = true;
  String? _errorMessage;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _handleRegister() {
    final name = _nameController.text.trim();
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();
    final confirm = _confirmPasswordController.text.trim();

    if (name.isEmpty) {
      setState(() => _errorMessage = 'Nama lengkap wajib diisi');
      return;
    }
    if (email.isEmpty) {
      setState(() => _errorMessage = 'Email wajib diisi');
      return;
    }
    if (password.length < 6) {
      setState(() => _errorMessage = 'Kata sandi minimal 6 karakter');
      return;
    }
    if (password != confirm) {
      setState(() => _errorMessage = 'Konfirmasi kata sandi tidak cocok');
      return;
    }

    final success = widget.authController.register(
      fullName: name,
      email: email,
      password: password,
    );
    if (success) {
      Navigator.pop(context);
      widget.onRegisterSuccess();
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = widget.themeController.isDarkMode;
    final t = widget.localeController.t;

    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF0C0B18) : AppColors.background,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new_rounded,
              size: 20, color: isDark ? Colors.white : AppColors.midnight),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          t('register'),
          style: AppTypography.headingMedium.copyWith(
            color: isDark ? Colors.white : AppColors.midnight,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
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
                      t('create_account'),
                      style: AppTypography.headingLarge.copyWith(
                        color: isDark ? Colors.white : AppColors.midnight,
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      decoration: BoxDecoration(
                        color: isDark ? const Color(0xFF221E40) : AppColors.orangeCream,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: AppColors.orangePrimary.withValues(alpha: 0.3),
                        ),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.stars_rounded, color: AppColors.orangePrimary, size: 18),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              'Dapatkan voucher Rp 250rb & +1.200 Miles saat mendaftar!',
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w700,
                                color: isDark ? Colors.white : AppColors.midnight,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 18),

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

                    _buildField(
                      label: t('full_name'),
                      hint: t('full_name_hint'),
                      controller: _nameController,
                      icon: Icons.person_outline_rounded,
                      isDark: isDark,
                    ),
                    const SizedBox(height: 14),

                    _buildField(
                      label: t('email'),
                      hint: t('email_hint'),
                      controller: _emailController,
                      icon: Icons.alternate_email_rounded,
                      isDark: isDark,
                    ),
                    const SizedBox(height: 14),

                    _buildField(
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
                    const SizedBox(height: 14),

                    _buildField(
                      label: t('confirm_password'),
                      hint: t('password_hint'),
                      controller: _confirmPasswordController,
                      icon: Icons.lock_reset_rounded,
                      isDark: isDark,
                      isPassword: true,
                      obscureText: _obscurePassword,
                    ),

                    const SizedBox(height: 24),

                    InteractiveScaleButton(
                      onPressed: _handleRegister,
                      child: Container(
                        height: 52,
                        decoration: BoxDecoration(
                          gradient: AppColors.sunsetOrangeGradient,
                          borderRadius: BorderRadius.circular(26),
                          boxShadow: AppShadows.orangeGlow,
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          t('create_account'),
                          style: AppTypography.headingMedium.copyWith(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    t('already_have_account'),
                    style: TextStyle(
                      fontSize: 13,
                      color: isDark ? const Color(0xFF9E9BAC) : AppColors.slateMuted,
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Text(
                      t('signin_now'),
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w800,
                        color: AppColors.orangePrimary,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 18),

              // Continue as Guest alternative
              Center(
                child: TextButton.icon(
                  onPressed: () {
                    widget.authController.loginAsGuest();
                    Navigator.pop(context);
                    widget.onRegisterSuccess();
                  },
                  icon: const Icon(Icons.person_pin_circle_outlined, size: 16, color: AppColors.orangePrimary),
                  label: Text(
                    t('guest_login_btn'),
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: isDark ? const Color(0xFFC7C5DC) : AppColors.midnight,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildField({
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
              suffixIcon: isPassword && onToggleObscure != null
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
}
