import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'core/localization/locale_controller.dart';
import 'core/theme/app_theme.dart';
import 'core/theme/theme_controller.dart';
import 'presentation/controllers/auth_controller.dart';
import 'presentation/screens/auth/login_screen.dart';
import 'presentation/screens/main_shell_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: Colors.transparent,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
    );
  } catch (_) {}

  try {
    await initializeDateFormatting('id_ID', null);
  } catch (e) {
    debugPrint('Locale notice: $e');
  }

  // Visual error fallback
  ErrorWidget.builder = (FlutterErrorDetails details) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F8FC),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.flight_takeoff_rounded, size: 48, color: Color(0xFFFF7A45)),
              const SizedBox(height: 16),
              const Text(
                'AeroNest Flight Experience',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF14132A),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                '${details.exception}',
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 12, color: Color(0xFF6B6888)),
              ),
            ],
          ),
        ),
      ),
    );
  };

  runApp(const AeroNestApp());
}

class AeroNestApp extends StatefulWidget {
  const AeroNestApp({super.key});

  @override
  State<AeroNestApp> createState() => _AeroNestAppState();
}

class _AeroNestAppState extends State<AeroNestApp> {
  final AuthController _authController = AuthController();
  final LocaleController _localeController = LocaleController();
  final ThemeController _themeController = ThemeController();

  @override
  void dispose() {
    _authController.dispose();
    _localeController.dispose();
    _themeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: Listenable.merge([
        _authController,
        _localeController,
        _themeController,
      ]),
      builder: (context, _) {
        return MaterialApp(
          title: 'AeroNest - 3D Flight Experience',
          debugShowCheckedModeBanner: false,
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: _themeController.themeMode,
          home: _authController.isLoggedIn
              ? MainShellScreen(
                  authController: _authController,
                  localeController: _localeController,
                  themeController: _themeController,
                )
              : LoginScreen(
                  authController: _authController,
                  localeController: _localeController,
                  themeController: _themeController,
                  onLoginSuccess: () {},
                ),
        );
      },
    );
  }
}
