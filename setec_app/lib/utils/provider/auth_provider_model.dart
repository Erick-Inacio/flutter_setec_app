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

  final logger = Logger();

  void setUserApp(UserApp userApp) async {
    _user = userApp;
    notifyListeners();

    late SharedPreferences prefs;

    try {
      prefs = await SharedPreferences.getInstance();

      await prefs.setString("user", json.encode(_user!.toJson()));
      prefs.setString('userType', 'userApp');

      _isFirstCheck = false;
      notifyListeners();
    } on Exception catch (e) {
      logger.e('Erro ao setar UserApp: $e');
      prefs.remove('user');
      prefs.remove('userType');
      rethrow;
    }
  }

  void setSpeaker(
    Speaker speaker,
  ) async {
    _user = speaker;
    notifyListeners();

    late SharedPreferences prefs;

    try {
      prefs = await SharedPreferences.getInstance();
      prefs.setString("user", json.encode(_user.toJson()));
      prefs.setString('userType', 'speaker');
      Logger().i(_user.toJson());
      Logger().i(prefs.getString("user"));

      _isFirstCheck = false;
      notifyListeners();
    } on Exception catch (e) {
      logger.e('Erro ao setar Speaker: $e');
      prefs.remove('user');
      prefs.remove('userType');
      rethrow;
    }
  }

  Future<void> loadUserFromPreferences() async {
    late SharedPreferences prefs;
    try {
      prefs = await SharedPreferences.getInstance();
      final userRestored = prefs.getString("user");
      final userType = prefs.getString("userType");

      //   //Codigo para limpar user local
      //   if (userRestored != null) {
      //     _isFirstCheck = true;
      //     //..descomentar essa linha e ...
      //     prefs.clear();
      //     notifyListeners();
      //     return;
      //   }
      //   if (_user == null) {
      //     _isFirstCheck = false;
      //     notifyListeners();
      //     return;
      //   }
      //   notifyListeners();
      // }

      //Codigo padrão
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
    } on Exception catch (e) {
      logger.i('Erro ao carregar usuário local: $e');
      prefs.remove('user');
      prefs.remove('userType');
      rethrow;
    }
  }

  // void enterAsGuest() {
  //   _user = null;
  //   notifyListeners();
  // }

  Future<void> signOut() async {
    try {
      final authService = AuthService();
      await authService.logout();
      _user = null;
      final prefs = await SharedPreferences.getInstance();
      await prefs.clear();
      notifyListeners();
    } on Exception catch (e) {
      logger.e('Erro ao deslogar usuário local + firebase: $e');
      rethrow;
    }
  }
}
