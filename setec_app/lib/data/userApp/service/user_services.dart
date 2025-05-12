import 'package:setec_app/data/userApp/dto/user_app_dto.dart';
import 'package:setec_app/core/base/base_service.dart';
import 'package:setec_app/data/core/endpoints/user_routes.dart';

class UserServices extends BaseService<UserAppDTO> {
  UserServices()
      : super(
          apiRoute: UserRoutes(),
          fromJson: (json) => UserAppDTO.fromJson(json),
          toJson: (user) => user.toJson(),
        );

  // final Dio _dio = Dio();

  // Future<Result<UserAppDTO>> getByUid(int id) async {
  //   return handleResult(() async {
  //     final routes = UserRoutes();
  //     final result = await getAuthHeaders();

  //     switch (result) {
  //       case Ok(value: final header):
  //         Logger().i('UserServices: $header');

  //         final response = await _dio.get(
  //           routes.getById(id),
  //           options: Options(headers: header),
  //         );

  //         if (response.statusCode == 404) {
  //           throw AppException("Usuário não encontrado", statusCode: 404);
  //         }

  //         final data = response.data as Map<String, dynamic>;
  //         return UserAppDTO.fromJson(data);

  //       case Error(error: final e):
  //         throw e; // erro de token ausente ou inválido
  //     }
  //   });
  // }
}
