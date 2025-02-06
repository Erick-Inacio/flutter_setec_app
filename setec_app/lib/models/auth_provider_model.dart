import 'package:flutter/material.dart';
import 'package:setec_app/models/speaker_model.dart';
import 'package:setec_app/models/user_app_model.dart';
import 'package:setec_app/services/firebase/auth/auth_service.dart';
import 'package:setec_app/utils/enums/relationship.dart';
import 'package:setec_app/utils/enums/roles.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider with ChangeNotifier {
  dynamic _userApp;
  bool _isFirstCheck = true;

  UserApp? get userApp => _userApp;

  bool get isAuthenticated => _userApp != null;
  bool get isSpeaker => _userApp is Speaker;
  bool get isGuest => _userApp == null;
  bool get isFirstCheck => _isFirstCheck;

  void setUserApp(UserApp? userApp) async {
    _userApp = userApp;
    notifyListeners();

    final prefs = await SharedPreferences.getInstance();

    if (userApp != null) {
      await Future.wait([
        prefs.setInt("id", userApp.id as int),
        prefs.setString("uid", userApp.uid),
        prefs.setString("name", userApp.name),
        prefs.setString("email", userApp.email),
        prefs.setString("role", userApp.role.name),
        prefs.setString("relationship", userApp.relationship.name),
      ]);

      if (userApp.ra.isNotEmpty) {
        await prefs.setString("ra", userApp.ra);
      }

      _isFirstCheck = false;
      notifyListeners();
    } else {
      await Future.wait([
        prefs.remove("id"),
        prefs.remove("uid"),
        prefs.remove("name"),
        prefs.remove("email"),
        prefs.remove("role"),
        prefs.remove("ra"),
      ]);
      _isFirstCheck = true;
    }
  }

  Future<void> loadUserFromPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    final id = prefs.getInt("id");
    final uid = prefs.getString("uid");
    final name = prefs.getString("name");
    final email = prefs.getString("email");
    final role = prefs.getString("role");
    final ra = prefs.getString("ra");
    final relationship = prefs.getString("relationship");

    // Logger().i(
    //     "id: $id, uid: $uid, name: $name, email: $email, role: $role, ra: $ra, relationship: $relationship");

    if (id == null ||
        uid == null ||
        name == null ||
        email == null ||
        role == null ||
        relationship == null) {
      _isFirstCheck = false;
      notifyListeners();
      return;
    }

    _userApp = UserApp(
      id: id,
      uid: uid,
      name: name,
      email: email,
      role: Roles.fromString(role),
      ra: ra ?? "",
      relationship: Relationship.fromString(relationship),
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
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    notifyListeners();
  }
}
  // void turningIntoASpeaker(
  //   String socialMedia,
  //   String company,
  //   String position,
  //   String bio,
  // ) async {
  //   if (_userApp != null) {
  //     _userApp = Speaker(
  //       userApp: _userApp as UserApp,
  //       socialMedia: socialMedia,
  //       company: company,
  //       position: position,
  //       bio: bio,
  //     );
  //     notifyListeners();

  //     final prefs = await SharedPreferences.getInstance();
  //     prefs.setString("social_media", socialMedia);
  //     prefs.setString("company", company);
  //     prefs.setString("position", position);
  //     prefs.setString("bio", bio);
  //   }
  // }

  // void turningIntoAStudent() async {
  //   if (_userApp != null) {
  //     _userApp = UserApp(
  //       id: _userApp!.id,
  //       uid: _userApp!.uid,
  //       name: _userApp!.name,
  //       email: _userApp!.email,
  //       role: _userApp!.role,
  //       ra: _userApp!.ra,
  //       relationship: _userApp!.relationship,
  //     );
  //     notifyListeners();

  //     final prefs = await SharedPreferences.getInstance();
  //     prefs.remove("social_media");
  //     prefs.remove("company");
  //     prefs.remove("position");
  //     prefs.remove("bio");
  //   }
  //   _isFirstCheck = false;
  //   notifyListeners();
  // }

