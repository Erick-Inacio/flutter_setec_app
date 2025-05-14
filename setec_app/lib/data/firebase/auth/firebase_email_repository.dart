import 'package:firebase_auth/firebase_auth.dart';
import 'package:logger/logger.dart';
import 'package:setec_app/core/classes/app_exception_class.dart';
import 'package:setec_app/core/classes/result_class.dart';
import 'package:setec_app/data/userApp/dto/user_app_dto.dart';
import 'package:setec_app/data/firebase/auth/firebase_services.dart';
import 'package:setec_app/data/userApp/service/user_services.dart';
import 'package:setec_app/model/models/user_app.dart';

class FirebaseEmailReapository {
  //Cria uma instancia de AuthEmailFirebase
  final _authEmail = AuthEmailFirebase();
  final _userServices = UserServices();
  final logger = Logger();

  //Retorna o usuário atual
  User? get currentUser => FirebaseAuth.instance.currentUser;

  //Realiza o login com email e senha
  Future<Result<UserApp>> login(String email, String password) async {
    return handleResult(() async {
      final user = await _authEmail.login(email, password);

      if (user == null) {
        throw AppException("Usuário não encontrado", statusCode: 404);
      }

      final idTokenResult = await user.getIdTokenResult();
      final claims = idTokenResult.claims;

      if (claims == null || !claims.containsKey('userId')) {
        throw AppException("Token inválido", statusCode: 401);
      }

      final userIdRaw = claims['userId'];

      final userId = switch (userIdRaw) {
        int() => userIdRaw,
        String() => int.tryParse(userIdRaw),
        double() => userIdRaw.toInt(),
        _ => null,
      };

      if (userId == null) {
        throw AppException("Token inválido", statusCode: 401);
      }

      final result = await _userServices.getById(userId);

      switch (result) {
        case Ok(value: final userAppDTODTO):
          return userAppDTODTO.toDomain();
        case Error(error: final e):
          throw e is AppException
              ? e
              : AppException("Erro ao buscar usuário: $e", statusCode: 500);
      }
    });
  }

  //Cadastra um novo usuário com email e senha
  Future<Result<UserAppDTO>> registerWithEmail({
    required String email,
    required String password,
  }) async {
    return handleResult(() async {
      final userAppDTO = await _authEmail.register(email, password);

      // final userAppDTO = userAppDTODTO?.toDomain();

      if (userAppDTO == null || userAppDTO.uid.isEmpty) {
        throw AppException("Erro ao cadastrar usuário no backend",
            statusCode: 400); //await fetchUserData(user.uid);
      }

      logger.i("AuthServices: Usuário cadastrado com sucesso");
      return userAppDTO;
    });
  }

  //Obten o token do usuario do firebase
  Future<Result<String?>> getUserToken() async {
    return handleResult(() async {
      var user = FirebaseAuth.instance.currentUser;

      UserCredential? userAnonymous;
      if (user == null) {
        final auth = FirebaseAuth.instance;
        userAnonymous = await auth.signInAnonymously();
        user = userAnonymous.user;
      }
      // await Future.delayed(Duration(milliseconds: 300));
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
