import 'package:flutter/material.dart';

class AuthController extends ChangeNotifier {
  bool _isLoggedIn = false;
  bool _isGuest = false;
  String _userName = 'Ajeng Pratama';
  String _userEmail = 'ajeng.pratama@aeronest.io';

  bool get isLoggedIn => _isLoggedIn;
  bool get isGuest => _isGuest;
  String get userName => _userName;
  String get userEmail => _userEmail;

  bool login({required String email, required String password}) {
    if (email.trim().isNotEmpty && password.length >= 6) {
      _userEmail = email.trim();
      if (_userName.isEmpty || _isGuest) {
        _userName = email.split('@').first;
      }
      _isLoggedIn = true;
      _isGuest = false;
      notifyListeners();
      return true;
    }
    return false;
  }

  bool register({
    required String fullName,
    required String email,
    required String password,
  }) {
    if (fullName.trim().isNotEmpty && email.trim().isNotEmpty && password.length >= 6) {
      _userName = fullName.trim();
      _userEmail = email.trim();
      _isLoggedIn = true;
      _isGuest = false;
      notifyListeners();
      return true;
    }
    return false;
  }

  void loginAsGuest() {
    _isLoggedIn = true;
    _isGuest = true;
    _userName = 'Tamu AeroNest';
    _userEmail = 'tamu@aeronest.io';
    notifyListeners();
  }

  void logout() {
    _isLoggedIn = false;
    _isGuest = false;
    notifyListeners();
  }
}
