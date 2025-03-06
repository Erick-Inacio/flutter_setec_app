import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:setec_app/models/speaker_model.dart';
import 'package:setec_app/models/user_app_model.dart';
import 'package:setec_app/services/firebase/auth/auth_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider with ChangeNotifier {
  dynamic _user;
  bool _isFirstCheck = true;

  dynamic get actualUser => _user;

  bool get isAuthenticated => _user != null;
  bool get isSpeaker => _user is Speaker;
  bool get isGuest => _user == null;
  bool get isFirstCheck => _isFirstCheck;

  void setUserApp(UserApp userApp) async {
    _user = userApp;
    notifyListeners();

    final prefs = await SharedPreferences.getInstance();

    await prefs.setString("user", json.encode(_user!.toJson()));
    prefs.setString('userType', 'userApp');

    _isFirstCheck = false;
    notifyListeners();
  }

  void setSpeaker(
    Speaker speaker,
  ) async {
    _user = speaker;
    notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    prefs.setString("user", json.encode(_user.toJson()));
    prefs.setString('userType', 'speaker');
    Logger().i(_user.toJson());
    Logger().i(prefs.getString("user"));

    _isFirstCheck = false;
    notifyListeners();
  }

  Future<void> loadUserFromPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    final userRestored = prefs.getString("user");
    final userType = prefs.getString("userType");

    if (userRestored == null) {
      _isFirstCheck = true;
      notifyListeners();
      return;
    }

    if (userType == 'speaker') {
      _user =
          Speaker.fromJson(json.decode(userRestored) as Map<String, dynamic>);
    } else {
      _user =
          UserApp.fromJson(json.decode(userRestored) as Map<String, dynamic>);
    }
    if (_user == null) {
      _isFirstCheck = false;
      notifyListeners();
      return;
    }
    notifyListeners();
  }

  void enterAsGuest() {
    _user = null;
    notifyListeners();
  }

  Future<void> signOut() async {
    final authService = AuthService();
    await authService.logout();
    _user = null;
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    notifyListeners();
  }
}
