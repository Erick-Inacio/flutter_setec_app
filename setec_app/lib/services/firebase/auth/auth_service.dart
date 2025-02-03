import 'package:firebase_auth/firebase_auth.dart' hide AuthProvider;

import 'package:logger/logger.dart';
import 'package:setec_app/models/user_app_model.dart';
import 'package:setec_app/services/backend/user_service.dart';
import 'package:setec_app/services/firebase/auth/auth_email_firebase.dart';

class AuthService {
  //Cria uma instancia de AuthEmailFirebase
  final AuthEmailFirebase _authEmail = AuthEmailFirebase();
  Logger logger = Logger();

  //Retorna o usuário atual
  User? get currentUser => FirebaseAuth.instance.currentUser;

  //Realiza o login com email e senha
  Future<UserApp?> login(String email, String password) async {
    try {
      User? user = await _authEmail.login(email, password);

      if (user != null) {
        //Busca os dados no Backend
        logger.i("Usuário logado com sucesso");
        return await UserServices.getUser(user.uid);
      }
      return null;
    } on FirebaseAuthException catch (e, stackTrace) {
      logger.e("Erro ao logar: $e", stackTrace: stackTrace);
      return null;
    }
  }

  //Cadastra um novo usuário com email e senha
  Future<UserApp?> registerWithEmail(String email, String password) async {
    UserApp? userApp = await _authEmail.register(email, password);

    if (userApp != null && userApp.uid.isNotEmpty) {
      //Busca os dados no Backend
      logger.i("Usuário cadastrado com sucesso");
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
}
