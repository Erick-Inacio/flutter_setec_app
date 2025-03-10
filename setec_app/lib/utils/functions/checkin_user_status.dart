import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:setec_app/models/speaker_model.dart';
import 'package:setec_app/models/user_app_model.dart';
import 'package:setec_app/utils/enums/roles.dart';
import 'package:setec_app/utils/provider/auth_provider_model.dart';

class CheckingUserStatus {
  static final CheckingUserStatus _instance = CheckingUserStatus._internal();
  BuildContext? _context;

  CheckingUserStatus._internal();
  factory CheckingUserStatus() => _instance;

  void setContext(BuildContext value) => _context = value;

  AuthProvider? _getAuthProvider() {
    final context = _context;
    if (context == null) return null;
    return Provider.of<AuthProvider>(context, listen: false);
  }

  UserApp getUserApp() {
    final user = _getAuthProvider()?.actualUser;
    if (user == null) return UserApp.empty();
    return user is Speaker ? user.user : user as UserApp;
  }

  Roles? getRole() => getUserApp().role;

  bool isSpeaker() => getUserApp().role == Roles.speaker;
  bool isAdmin() => getUserApp().role == Roles.admin;
  bool isStudent() => getUserApp().role == Roles.student;

  bool isAuthenticated() => _getAuthProvider()?.isAuthenticated ?? false;
}
