import 'package:firebase_auth/firebase_auth.dart';

import 'package:logger/logger.dart';
import 'package:setec_app/core/classes/app_exception_class.dart';
import 'package:setec_app/core/classes/result_class.dart';
import 'package:setec_app/data/userApp/service/user_services.dart';
import 'package:setec_app/data/firebase/auth/auth_email_firebase.dart';
import 'package:setec_app/domain/models/user_app.dart';

class AuthRepository {
  //Cria uma instancia de AuthEmailFirebase
  final AuthEmailFirebase _authEmail = AuthEmailFirebase();
  final UserServices _userServices = UserServices();
  Logger logger = Logger();

  //Retorna o usuário atual
  User? get currentUser => FirebaseAuth.instance.currentUser;

  //Realiza o login com email e senha
  Future<Result<UserApp>> login(String email, String password) async {
    return handleResult(() async {
      final user = await _authEmail.login(email, password);

      if (user == null) {
        throw AppException("Usuário não encontrado", statusCode: 404);
      }

      final result = await _userServices.getByUid(user.uid);

      switch (result) {
        case Ok(value: final userAppDTO):
          return userAppDTO.toDomain();
        case Error(error: final e):
          throw e is AppException
              ? e
              : AppException("Erro ao buscar usuário: $e", statusCode: 500);
      }
    });
  }

  //Cadastra um novo usuário com email e senha
  Future<Result<UserApp>> registerWithEmail(
      String email, String password) async {
    return handleResult(() async {
      final userAppDTO = await _authEmail.register(email, password);

      final userApp = userAppDTO?.toDomain();

      if (userApp == null || userApp.uid.isEmpty) {
        throw AppException("Erro ao cadastrar usuário no backend",
            statusCode: 400); //await fetchUserData(user.uid);
      }

      logger.i("AuthServices: Usuário cadastrado com sucesso");
      return userApp;
    });
  }

  //Obten o token do usuario do firebase
  Future<Result<String?>> getUserToken() async {
    return handleResult(() async {
      final user = FirebaseAuth.instance.currentUser;
      final token = await user?.getIdToken(true);
      if (token == null) {
        throw AppException('Usuário não autenticado', statusCode: 401);
      }
      return token;
    });
  }

  //Desloga o usuário
  Future<Result<void>> logout() async {
    return handleResult(() async {
      await _authEmail.logout();
    });
  }

  //Deleta o usuario do firebase
  Future<Result<void>> deleteUser() async {
    return handleResult(() async {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        throw AppException("Usuário não autenticado", statusCode: 401);
      }
      await user.delete();
    });
  }
}
