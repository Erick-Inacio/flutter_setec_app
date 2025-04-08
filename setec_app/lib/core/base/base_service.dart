import 'package:setec_app/core/classes/app_exception_class.dart';
import 'package:setec_app/core/classes/result_class.dart';
import 'package:setec_app/data/firebase/auth/auth_repository.dart';
import 'package:dio/dio.dart';
import 'package:setec_app/data/core/base_routes.dart';

abstract class BaseService<T> {
  BaseService({
    required this.apiRoute,
    required this.fromJson,
    required this.toJson,
  });

  final BaseRoutes apiRoute;
  final T Function(Map<String, dynamic>) fromJson;
  final Map<String, dynamic> Function(T) toJson;

  final AuthRepository auth = AuthRepository();

  final Dio _dio = Dio();

  //Métodos https genéricos
  //Get all
  Future<Result<List<T>>> getAll() async {
    return handleResult(() async {
      final header = await getAuthHeaders();

      final response = await _dio.get(
        apiRoute.getAll(),
        options: Options(
          headers: header,
        ),
      );
      final data = response.data as List;
      return data.map((e) => fromJson(e)).toList();
    });
  }

  //Get by id
  Future<Result<T>> getById(int id) async {
    return handleResult(() async {
      final header = await getAuthHeaders();

      final response = await _dio.get(
        apiRoute.getById(id),
        options: Options(
          headers: header,
        ),
      );
      final data = response.data as Map<String, dynamic>;
      return fromJson(data);
    });
  }

  //Post
  Future<Result<T>> post(T t) async {
    return handleResult(() async {
      final header = await getAuthHeaders();

      final response = await _dio.post(
        apiRoute.post(),
        options: Options(
          headers: header,
        ),
        data: toJson(t),
      );

      final data = response.data as Map<String, dynamic>;
      return fromJson(data);
    });
  }

  //put
  Future<Result<T>> put(T t) async {
    return handleResult(() async {
      final header = await getAuthHeaders();

      final response = await _dio.put(
        apiRoute.put(),
        options: Options(
          headers: header,
        ),
        data: toJson(t),
      );

      final data = response.data as Map<String, dynamic>;
      return fromJson(data);
    });
  }

  //delete
  Future<Result<void>> delete(int t) async {
    return handleResult(() async {
      final header = await getAuthHeaders();

      final response = await _dio.delete(
        apiRoute.delete(t),
        options: Options(
          headers: header,
        ),
      );
      if (response.statusCode == 204) {
        return;
      } else {
        throw AppException(
          "Failed to delete event, status: ${response.statusCode}",
          statusCode: response.statusCode,
        );
      }
    });
  }

  Future<Map<String, String>> getAuthHeaders() async {
    final token = await auth.getUserToken();
    return {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    };
  }
}
