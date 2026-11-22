import 'package:flutter/material.dart';
import 'app_locale.dart';

class LocaleController extends ChangeNotifier {
  AppLanguage _currentLanguage = AppLanguage.id;

  AppLanguage get currentLanguage => _currentLanguage;

  void setLanguage(AppLanguage language) {
    if (_currentLanguage != language) {
      _currentLanguage = language;
      notifyListeners();
    }
  }

  String t(String key) {
    return AppLocale.getText(_currentLanguage, key);
  }
}
