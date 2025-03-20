import 'package:firebase_auth/firebase_auth.dart' hide MainProvider;

import 'package:logger/logger.dart';
import 'package:setec_app/models/user_app_model.dart';
import 'package:setec_app/services/backend/user_services.dart';
import 'package:setec_app/services/firebase/auth/auth_email_firebase.dart';

class AuthService {
  //Cria uma instancia de AuthEmailFirebase
  final AuthEmailFirebase _authEmail = AuthEmailFirebase();
  Logger logger = Logger();

  //Retorna o usuário atual
  User? get currentUser => FirebaseAuth.instance.currentUser;

  //Realiza o login com email e senha
  Future<UserApp?> login(String email, String password) async {
    UserApp? userApp;
    try {
      User? user = await _authEmail.login(email, password);

      if (user != null) {
        //Busca os dados no Backend
        logger.i("AuthServices: Usuário logado com sucesso");
        try {
          UserServices userServices = UserServices();
          userApp = await userServices.getByUid(user.uid);
          if (userApp != null) {
            return userApp;
          }
        } on Exception catch (e, stacktrace) {
          logger.e("AuthServices: Erro ao buscar dados do usuário: $e",
              stackTrace: stacktrace);
        }
      }
      return null;
    } on FirebaseAuthException catch (e, stackTrace) {
      logger.e("AuthServices: Erro ao logar: $e", stackTrace: stackTrace);
      return null;
    }
  }

  //Cadastra um novo usuário com email e senha
  Future<UserApp?> registerWithEmail(String email, String password) async {
    UserApp? userApp = await _authEmail.register(email, password);

    if (userApp != null && userApp.uid.isNotEmpty) {
      //Busca os dados no Backend
      logger.i("AuthServices: Usuário cadastrado com sucesso");
      return userApp; //await fetchUserData(user.uid);
    }
    return null;
  }

  //Obten o token do usuario do firebase
  Future<String?> getUserToken() async {
    final user = FirebaseAuth.instance.currentUser;
    return user != null ? await user.getIdToken(true) : null;
  }

  //Desloga o usuário
  Future<void> logout() async {
    await _authEmail.logout();
  }

  //Deleta o usuario do firebase
  Future<void> deleteUser() async {
    try {
      FirebaseAuth.instance.currentUser!.delete;
    } on Exception catch (e) {
      logger.e("AuthServices: Erro ao deletar usuário: $e");
    }
  }
}
