import 'package:flutter/material.dart';
import '../models/users_model.dart';
import '../services/auth_services.dart';

class AuthController extends ChangeNotifier {
  final AuthService _authService = AuthService();

  UserModel? _user;
  UserModel? get user => _user;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  /// REGISTER
  Future<void> register({
    required String email,
    required String password,
    required String displayName,
  }) async {
    try {
      _setLoading(true);
      _user = await _authService.register(
        email: email,
        password: password,
        displayName: displayName,
      );
      notifyListeners();
    } finally {
      _setLoading(false);
    }
  }

  /// LOGIN
  Future<void> login({
    required String email,
    required String password,
  }) async {
    try {
      _setLoading(true);
      _user = await _authService.login(
        email: email,
        password: password,
      );
      notifyListeners();
    } finally {
      _setLoading(false);
    }
  }

  /// LOGOUT
  Future<void> logout() async {
    if (_user == null) return;

    await _authService.logout();
    _user = null;
    notifyListeners();
  }

  /// CHECK AUTH STATE (on app start)
  Future<void> checkAuth() async {
    _user = await _authService.getCurrentUser();
    notifyListeners();
  }
}
