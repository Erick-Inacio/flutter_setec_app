import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:setec_app/core/classes/app_exception_class.dart';
import 'package:setec_app/core/classes/result_class.dart';
import 'package:setec_app/data/userApp/dto/user_app_dto.dart';
import 'package:setec_app/core/base/base_service.dart';
import 'package:setec_app/data/core/endpoints/user_routes.dart';
import 'package:setec_app/data/firebase/auth/auth_repository.dart';

class UserServices extends BaseService<UserAppDTO> {
  UserServices()
      : super(
          apiRoute: UserRoutes(),
          fromJson: (json) => UserAppDTO.fromJson(json),
          toJson: (user) => user.toJson(),
        );

  final Dio _dio = Dio();

  Future<Result<UserAppDTO>> getByUid(String uid) async {
    return handleResult(() async {
      final routes = UserRoutes();
      final authService = AuthRepository();
      final token = await authService.getUserToken();
      Logger().i('UserServices: $token');

      final response = await _dio.get(
        routes.getByUid(uid),
        options: Options(headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json'
        }),
      );

      if (response.statusCode == 404) {
        throw AppException("Usuário não encontrado", statusCode: 404);
      }

      final data = response.data as Map<String, dynamic>;
      return UserAppDTO.fromJson(data);
    });
  }
}
