import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:logger/web.dart';
import 'package:setec_app/data/userApp/dto/user_app_dto.dart';

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

  Future<UserAppDTO?> register(String email, String password) async {
    try {
      UserAppDTO userAppDTO = UserAppDTO.empty();
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);

      userAppDTO.uid = userCredential.user!.uid;
      userAppDTO.email = email;
      return userAppDTO;
    } on FirebaseAuthException catch (e, stackTrace) {
      logger.d("AuthEmailFirebase: $e", stackTrace: stackTrace);
      return null;
    }
  }

  Future<void> logout() async {
    await _auth.signOut();
  }
}
