import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:setec_app/models/speaker_model.dart';
import 'package:setec_app/models/user_app_model.dart';
import 'package:setec_app/services/firebase/auth/auth_service.dart';
import 'package:setec_app/utils/enums/social_media_enum.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider with ChangeNotifier {
  dynamic _user;
  bool _isFirstCheck = true;

  UserApp? get userApp => _user;

  bool get isAuthenticated => _user != null;
  bool get isSpeaker => _user is Speaker;
  bool get isGuest => _user == null;
  bool get isFirstCheck => _isFirstCheck;

  void setUserApp(UserApp? userApp) async {
    _user = userApp;
    notifyListeners();

    final prefs = await SharedPreferences.getInstance();

    if (userApp != null) {
      await prefs.setString("user", json.encode(_user!.toJson()));

      _isFirstCheck = false;
      notifyListeners();
    } else {
      await Future.wait([
        prefs.remove("user"),
      ]);
      _isFirstCheck = true;
    }
  }

  Future<void> loadUserFromPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    final userRestored = prefs.getString("user");

    if(userRestored == null) {
      _isFirstCheck = true;
      notifyListeners();
      return;
    }

    final userMap = UserApp.fromJson(json.decode(userRestored) as Map<String, dynamic>);
    

    if (userMap.id == null) {
      _isFirstCheck = false;
      notifyListeners();
      return;
    }

    _user = userMap;
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

  void turningIntoASpeaker(
    Map<SocialMedia, String> socialMedia,
    String company,
    String position,
    String bio,
  ) async {
    if (_user != null) {
      _user = Speaker(
         user: _user!,
        socialMedia: socialMedia,
        company: company,
        position: position,
        bio: bio,
      );
      notifyListeners();

      final prefs = await SharedPreferences.getInstance();
      prefs.setString("speaker", json.encode(_user!.toJson()));
    }
  }

  void turningIntoAStudent() async {
    if (_user != null) {
      _user = UserApp(
        id: _user!.id,
        uid: _user!.uid,
        name: _user!.name,
        email: _user!.email,
        role: _user!.role,
        ra: _user!.ra,
        relationship: _user!.relationship,
      );
      notifyListeners();

      final prefs = await SharedPreferences.getInstance();
      prefs.remove("speaker");
    }
    _isFirstCheck = false;
    notifyListeners();
  }

}