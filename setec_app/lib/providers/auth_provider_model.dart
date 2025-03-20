import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:setec_app/models/speaker_model.dart';
import 'package:setec_app/models/user_app_model.dart';
import 'package:setec_app/providers/speaker_provider.dart';
import 'package:setec_app/providers/user_app_provider.dart';
import 'package:setec_app/services/firebase/auth/auth_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider with ChangeNotifier {
  dynamic _user;
  // bool //_isFirstCheck = true;

  dynamic get actualUser => _user;

  bool get isAuthenticated => _user != null;
  bool get isSpeaker => _user is Speaker;
  // bool get isGuest => _user == null;
  // bool get isFirstCheck => //_isFirstCheck;

  final logger = Logger();

  void setUserApp(UserApp userApp) async {
    UserAppProvider userAppProvider = UserAppProvider();

    try {
      userAppProvider.saveDataToLocal(userApp);
      _user = userApp;
      //_isFirstCheck = false;
      notifyListeners();
    } on Exception catch (e) {
      logger.e('Erro ao setar UserApp: $e');
      rethrow;
    }
  }

  void setSpeaker(Speaker speaker) async {
    SpeakerProvider speakerProvider = SpeakerProvider();
    try {
      speakerProvider.saveDataToLocal(speaker);
      _user = speaker;
      //_isFirstCheck = false;
      notifyListeners();
    } on Exception catch (e) {
      logger.e('Erro ao setar Speaker: $e');
      rethrow;
    }
  }

  Future<void> loadUserFromPreferences() async {
    try {
      UserAppProvider userAppProvider = UserAppProvider();

      dynamic aux = await userAppProvider.loadDataFromLocal();
      if (aux != null) {
        _user = UserApp.fromJson(aux);
        //_isFirstCheck = false;
      } else {
        SpeakerProvider speakerProvider = SpeakerProvider();

        aux = await speakerProvider.loadDataFromLocal();
        if (aux != null) {
          _user = Speaker.fromJson(aux);
          //_isFirstCheck = false;
        } else {
          _user = null;
        }
      }
    } on Exception catch (e) {
      logger.e('Erro ao carregar dados locais: $e');
      rethrow;
    }
  }

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


//   void setUserApp(UserApp userApp) async {
//     _user = userApp;
//     notifyListeners();

//     late SharedPreferences prefs;

//     try {
//       prefs = await SharedPreferences.getInstance();

//       await prefs.setString("user", json.encode(_user!.toJson()));
//       prefs.setString('userType', 'userApp');

//       //_isFirstCheck = false;
//       notifyListeners();
//     } on Exception catch (e) {
//       logger.e('Erro ao setar UserApp: $e');
//       prefs.remove('user');
//       prefs.remove('userType');
//       rethrow;
//     }
//   }

//   void setSpeaker(
//     Speaker speaker,
//   ) async {
//     _user = speaker;
//     notifyListeners();

//     late SharedPreferences prefs;

//     try {
//       prefs = await SharedPreferences.getInstance();
//       prefs.setString("user", json.encode(_user.toJson()));
//       prefs.setString('userType', 'speaker');
//       Logger().i(_user.toJson());
//       Logger().i(prefs.getString("user"));

//       //_isFirstCheck = false;
//       notifyListeners();
//     } on Exception catch (e) {
//       logger.e('Erro ao setar Speaker: $e');
//       prefs.remove('user');
//       prefs.remove('userType');
//       rethrow;
//     }
//   }

//   Future<void> loadUserFromPreferences() async {
//     late SharedPreferences prefs;
//     try {
//       prefs = await SharedPreferences.getInstance();
//       final userRestored = prefs.getString("user");
//       final userType = prefs.getString("userType");

//       //   //Codigo para limpar user local
//       //   if (userRestored != null) {
//       //     //_isFirstCheck = true;
//       //     prefs.clear();
//       //     FirebaseAuth.instance.signOut();
//       //     notifyListeners();
//       //     return;
//       //   }
//       //   if (_user == null) {
//       //     //_isFirstCheck = false;
//       //     notifyListeners();
//       //     return;
//       //   }
//       //   notifyListeners();
//       // }

//       //Codigo padrão
//       if (userRestored == null) {
//         //_isFirstCheck = true;
//         notifyListeners();
//         return;
//       }

//       if (userType == 'speaker') {
//         _user =
//             Speaker.fromJson(json.decode(userRestored) as Map<String, dynamic>);
//       } else {
//         _user =
//             UserApp.fromJson(json.decode(userRestored) as Map<String, dynamic>);
//       }
//       if (_user == null) {
//         //_isFirstCheck = false;
//         notifyListeners();
//         return;
//       }
//       notifyListeners();
//     } on Exception catch (e) {
//       logger.i('Erro ao carregar usuário local: $e');
//       prefs.remove('user');
//       prefs.remove('userType');
//       rethrow;
//     }
//   }
// }
  // void enterAsGuest() {
  //   _user = null;
  //   notifyListeners();
  // }
