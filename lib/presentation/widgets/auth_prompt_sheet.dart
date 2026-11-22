import 'package:flutter/material.dart';
import '../../core/localization/locale_controller.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_shadows.dart';
import '../../core/theme/app_typography.dart';
import '../../core/theme/theme_controller.dart';
import '../../core/widgets/interactive_scale_button.dart';
import '../controllers/auth_controller.dart';

class AuthPromptSheet extends StatefulWidget {
  final AuthController authController;
  final LocaleController localeController;
  final ThemeController themeController;
  final VoidCallback? onSuccess;

  const AuthPromptSheet({
    super.key,
    required this.authController,
    required this.localeController,
    required this.themeController,
    this.onSuccess,
  });

  static void show(
    BuildContext context, {
    required AuthController authController,
    required LocaleController localeController,
    required ThemeController themeController,
    VoidCallback? onSuccess,
  }) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => AuthPromptSheet(
        authController: authController,
        localeController: localeController,
        themeController: themeController,
        onSuccess: onSuccess,
      ),
    );
  }

  @override
  State<AuthPromptSheet> createState() => _AuthPromptSheetState();
}

class _AuthPromptSheetState extends State<AuthPromptSheet> {
  final _emailController = TextEditingController(text: 'ajeng@aeronest.io');
  final _passwordController = TextEditingController(text: 'secret123');
  bool _obscurePassword = true;
  bool _isRegisterMode = false;
  final _nameController = TextEditingController(text: 'Ajeng Pratama');
  String? _errorMessage;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  void _handleSubmit() {
    if (_isRegisterMode) {
      final name = _nameController.text.trim();
      final email = _emailController.text.trim();
      final pass = _passwordController.text.trim();
      if (name.isEmpty || email.isEmpty || pass.length < 6) {
        setState(() => _errorMessage = 'Mohon lengkapi semua data (sandi min 6 karakter)');
        return;
      }
      final ok = widget.authController.register(fullName: name, email: email, password: pass);
      if (ok) {
        Navigator.pop(context);
        widget.onSuccess?.call();
      }
    } else {
      final email = _emailController.text.trim();
      final pass = _passwordController.text.trim();
      if (email.isEmpty || pass.length < 6) {
        setState(() => _errorMessage = 'Email & kata sandi min 6 karakter');
        return;
      }
      final ok = widget.authController.login(email: email, password: pass);
      if (ok) {
        Navigator.pop(context);
        widget.onSuccess?.call();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = widget.themeController.isDarkMode;
    final t = widget.localeController.t;

    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Container(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.88,
        ),
        decoration: BoxDecoration(
          color: isDark ? const Color(0xFF14132A) : Colors.white,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.3),
              blurRadius: 24,
              offset: const Offset(0, -4),
            ),
          ],
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(24, 14, 24, 30),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Drag handle
              Center(
                child: Container(
                  width: 44,
                  height: 4,
                  decoration: BoxDecoration(
                    color: isDark ? const Color(0xFF33305B) : const Color(0xFFD8DDE8),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: 18),

              // Header Badge & Title
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: AppColors.orangeCream,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Text('✈️', style: TextStyle(fontSize: 20)),
                      ),
                      const SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _isRegisterMode ? t('register') : t('login'),
                            style: AppTypography.headingLarge.copyWith(
                              fontSize: 18,
                              color: isDark ? Colors.white : AppColors.midnight,
                            ),
                          ),
                          Text(
                            _isRegisterMode
                                ? 'Dapatkan akun penuh & diskon Rp 250rb'
                                : 'Masuk untuk sinkronisasi tiket & miles',
                            style: TextStyle(
                              fontSize: 11,
                              color: isDark ? const Color(0xFF9E9BAC) : AppColors.slateMuted,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  IconButton(
                    icon: Icon(Icons.close_rounded,
                        color: isDark ? Colors.white70 : AppColors.slateMuted),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              // Highlight Perks Box
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  gradient: isDark
                      ? const LinearGradient(
                          colors: [Color(0xFF242045), Color(0xFF1B1836)],
                        )
                      : const LinearGradient(
                          colors: [Color(0xFFFFF6F0), Color(0xFFFFECE0)],
                        ),
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(
                    color: AppColors.orangePrimary.withValues(alpha: 0.25),
                  ),
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.stars_rounded, color: AppColors.orangePrimary, size: 20),
                        const SizedBox(width: 8),
                        Text(
                          'Keuntungan Memiliki Akun Resmi:',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w800,
                            color: isDark ? Colors.white : AppColors.midnight,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    _buildPerkItem('🎁 Voucher Diskon Rp 250.000 otomatis aktif', isDark),
                    _buildPerkItem('🎫 E-Tiket & Boarding Pass tersimpan selamanya', isDark),
                    _buildPerkItem('⭐ Bonus sambutan +1.200 AeroMiles', isDark),
                  ],
                ),
              ),

              const SizedBox(height: 16),

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
                      fontWeight: FontWeight.w700,
                      color: AppColors.coralAlert,
                    ),
                  ),
                ),
                const SizedBox(height: 12),
              ],

              if (_isRegisterMode) ...[
                _buildField(
                  label: t('full_name'),
                  controller: _nameController,
                  icon: Icons.person_outline_rounded,
                  isDark: isDark,
                ),
                const SizedBox(height: 12),
              ],

              _buildField(
                label: t('email'),
                controller: _emailController,
                icon: Icons.alternate_email_rounded,
                isDark: isDark,
              ),
              const SizedBox(height: 12),

              _buildField(
                label: t('password'),
                controller: _passwordController,
                icon: Icons.lock_outline_rounded,
                isDark: isDark,
                isPassword: true,
                obscure: _obscurePassword,
                onToggleObscure: () => setState(() => _obscurePassword = !_obscurePassword),
              ),

              const SizedBox(height: 20),

              // Submit Button
              InteractiveScaleButton(
                onPressed: _handleSubmit,
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                    gradient: AppColors.sunsetOrangeGradient,
                    borderRadius: BorderRadius.circular(25),
                    boxShadow: AppShadows.orangeGlow,
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    _isRegisterMode ? t('signup_now') : t('login'),
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 14),

              // Mode toggle (Login <-> Register)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    _isRegisterMode ? t('already_have_account') : t('dont_have_account'),
                    style: TextStyle(
                      fontSize: 12,
                      color: isDark ? const Color(0xFF9E9BAC) : AppColors.slateMuted,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _isRegisterMode = !_isRegisterMode;
                        _errorMessage = null;
                      });
                    },
                    child: Text(
                      _isRegisterMode ? t('signin_now') : t('signup_now'),
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w800,
                        color: AppColors.orangePrimary,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPerkItem(String text, bool isDark) {
    return Padding(
      padding: const EdgeInsets.only(top: 4),
      child: Row(
        children: [
          const Icon(Icons.check_circle_rounded, size: 14, color: AppColors.mintSuccess),
          const SizedBox(width: 6),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: isDark ? const Color(0xFFC7C5DC) : AppColors.midnight,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildField({
    required String label,
    required TextEditingController controller,
    required IconData icon,
    required bool isDark,
    bool isPassword = false,
    bool obscure = false,
    VoidCallback? onToggleObscure,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 2),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1E1C38) : AppColors.surfaceSoft,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isDark ? const Color(0xFF2F2C55) : AppColors.borderLight,
        ),
      ),
      child: TextField(
        controller: controller,
        obscureText: obscure,
        style: TextStyle(
          fontSize: 13,
          color: isDark ? Colors.white : AppColors.midnight,
          fontWeight: FontWeight.w600,
        ),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(
            fontSize: 11,
            color: isDark ? const Color(0xFF9E9BAC) : AppColors.slateMuted,
          ),
          border: InputBorder.none,
          icon: Icon(icon, size: 18, color: AppColors.orangePrimary),
          suffixIcon: isPassword
              ? IconButton(
                  icon: Icon(
                    obscure ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                    size: 18,
                    color: isDark ? Colors.white60 : AppColors.slateMuted,
                  ),
                  onPressed: onToggleObscure,
                )
              : null,
        ),
      ),
    );
  }
}
