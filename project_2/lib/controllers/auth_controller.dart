import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../models/users_model.dart';
import '../routes/app_routes.dart';
import '../services/auth_services.dart';
import '../utils/session_manager.dart';

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
  // Future<void> logout() async {
  //   if (_user == null) return;
  //
  //   await _authService.logout();
  //   _user = null;
  //   notifyListeners();
  // }
  Future<void> logout() async {
    await FirebaseAuth.instance.signOut();

    // 🔥 clear all GetX memory
    SessionManager.clearSession();

    // 🔥 navigate cleanly
    Get.offAllNamed(AppRoutes.login);
  }


  /// CHECK AUTH STATE (on app start)
  Future<void> checkAuth() async {
    _user = await _authService.getCurrentUser();
    notifyListeners();
  }
}
