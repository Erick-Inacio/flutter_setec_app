import 'package:flutter/material.dart';
import 'package:setec_app/models/speaker_model.dart';
import 'package:setec_app/models/user_app_model.dart';
import 'package:setec_app/services/firebase/auth/auth_service.dart';
import 'package:setec_app/utils/enums/roles.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider with ChangeNotifier {
  UserApp? _userApp;

  UserApp? get userApp => _userApp;

  bool get isAuthenticated => _userApp != null;
  bool get isSpeaker => _userApp is Speaker;
  bool get isGuest => _userApp == null;

  void setUserApp(UserApp? userApp) async {
    _userApp = userApp;
    notifyListeners();

    final prefs = await SharedPreferences.getInstance();

    if (userApp != null) {
      int roleIndex = Roles.values
          .indexWhere((role) => role.toString() == "Roles.${userApp.role}");

      await prefs.setInt("user_id", userApp.id as int);
      await prefs.setString("user_uid", userApp.uid);
      await prefs.setString("user_name", userApp.name);
      await prefs.setString("user_email", userApp.email);
      await prefs.setInt("user_role", roleIndex);

      if (userApp.ra.isNotEmpty) {
        await prefs.setString("user_ra", userApp.ra);
      }
    } else {
      await prefs.remove("user_id");
      await prefs.remove("user_uid");
      await prefs.remove("user_name");
      await prefs.remove("user_email");
      await prefs.remove("user_role");
      await prefs.remove("user_ra");
    }
  }

  Future<void> loadUserFromPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getInt("user_id");
    final userUid = prefs.getString("user_uid");
    final userName = prefs.getString("user_name");
    final userEmail = prefs.getString("user_email");
    final userRoleId = prefs.getInt("user_role");
    final userRa = prefs.getString("user_ra");

    if (userId == null ||
        userUid == null ||
        userName == null ||
        userEmail == null ||
        userRoleId == null ||
        userRa == null) {
      return;
    }

    final userRole = Roles.values[userRoleId];
    _userApp = UserApp(
      id: userId,
      uid: userUid,
      name: userName,
      email: userEmail,
      role: userRole,
      ra: userRa,
    );
    notifyListeners();
  }

  void enterAsGuest() {
    _userApp = null;
    notifyListeners();
  }

  Future<void> signOut() async {
    final authService = AuthService();
    await authService.logout();
    _userApp = null;
    notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }

  void turningIntoASpeaker(
    String socialMedia,
    String company,
    String position,
    String bio,
  ) async {
    if (_userApp != null) {
      _userApp = Speaker(
        id: _userApp!.id,
        uid: _userApp!.uid,
        name: _userApp!.name,
        email: _userApp!.email,
        role: _userApp!.role,
        ra: _userApp!.ra,
        socialMedia: socialMedia,
        company: company,
        position: position,
        bio: bio,
      );
      notifyListeners();

      final prefs = await SharedPreferences.getInstance();
      prefs.setString("user_social_media", socialMedia);
      prefs.setString("user_company", company);
      prefs.setString("user_position", position);
      prefs.setString("user_bio", bio);
    }
  }

  void turningIntoAStudent() async {
    if (_userApp != null) {
      _userApp = UserApp(
        id: _userApp!.id,
        uid: _userApp!.uid,
        name: _userApp!.name,
        email: _userApp!.email,
        role: _userApp!.role,
        ra: _userApp!.ra,
      );
      notifyListeners();

      final prefs = await SharedPreferences.getInstance();
      prefs.remove("user_social_media");
      prefs.remove("user_company");
      prefs.remove("user_position");
      prefs.remove("user_bio");
    }
  }
}
