import 'package:flutter/material.dart';
import 'package:setec_app/core/classes/result_class.dart';
import 'package:setec_app/core/enums/roles.dart';
import 'package:setec_app/domain/models/speaker.dart';
import 'package:setec_app/domain/models/user_app.dart';

class SessionProvider with ChangeNotifier {
  dynamic _user;  

  dynamic get user => _user;
  bool get isAuthenticated => _user != null;
  bool get isUserApp => _user is UserApp;
  bool get isSpeaker => _user is Speaker;

  Roles? get role {
    if (_user is UserApp) return (_user as UserApp).role;
    if (_user is Speaker) return (_user as Speaker).user?.role;
    return null;
  }

  bool get isAdmin => role == Roles.admin;
  bool get isStudent => role == Roles.student;
  bool get isCommission => role == Roles.commission;

  void setUser(dynamic user) {
    _user = user;
    notifyListeners();
  }

  Future<Result<void>> clearSession() async {
    return handleResult(() async {
      _user = null;
      notifyListeners();
    });
  }

  // Future<Result<void>> loadSession() async {
  //   return handleResult(() async {
  //     final user = AuthRepository().currentUser;
  //     if (user != null) {
  //       await loadDataFromPreferences();
  //       await fetchEvents();
  //     }
  //   });
  // }
}
