import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:setec_app/models/speaker_model.dart';
import 'package:setec_app/models/user_app_model.dart';
import 'package:setec_app/utils/enums/roles.dart';
import 'package:setec_app/providers/main_provider.dart';

class CheckingUserStatus {
  static final CheckingUserStatus _instance = CheckingUserStatus._internal();
  BuildContext? _context;

  CheckingUserStatus._internal();
  factory CheckingUserStatus() => _instance;

  void setContext(BuildContext value) => _context = value;

  MainProvider? _getMainProvider() {
    final context = _context;
    if (context == null) return null;
    return Provider.of<MainProvider>(context, listen: false);
  }

  UserApp? getUserApp() {
    final user = _getMainProvider()?.actualUser;
    if (user == null) {
      return null;
    }

    if (user is Speaker) {
      if (user.user == null) {
        throw Exception("UserApp inside Speaker is null");
      }
      return user.user;
    }

    if (user is UserApp) {
      return user;
    }

    throw Exception("User is not a UserApp or Speaker");
  }

  Roles? getRole() => getUserApp()?.role;

  bool isSpeaker() => getUserApp()?.role == Roles.speaker;
  bool isAdmin() => getUserApp()?.role == Roles.admin;
  bool isStudent() => getUserApp()?.role == Roles.student;

  bool isAuthenticated() => _getMainProvider()?.isAuthenticated ?? false;
}
