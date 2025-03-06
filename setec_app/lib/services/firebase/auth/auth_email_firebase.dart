import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:logger/logger.dart';
import 'package:setec_app/models/user_app_model.dart';

class AuthEmailFirebase {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Logger logger = Logger();

  Future<User?> login(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return userCredential.user;
    } catch (e, stackTrace) {
      logger.e("AuthEmailFirebase: $e", stackTrace: stackTrace);

      if (e is FirebaseAuthException) {
        throw Exception(e.message);
      } else if (e is PlatformException) {
        throw Exception(e.message);
      } else {
        throw Exception("Erro inesperado: ${e.toString()}");
      }
    }
  }

  Future<UserApp?> register(String email, String password) async {
    try {
      UserApp userApp = UserApp.empty();
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);

      userApp.uid = userCredential.user!.uid;
      userApp.email = email;
      return userApp;
    } on FirebaseAuthException catch (e, stackTrace) {
      logger.d("AuthEmailFirebase: $e", stackTrace: stackTrace);
      return null;
    }
  }

  Future<void> logout() async {
    await _auth.signOut();
  }
}
