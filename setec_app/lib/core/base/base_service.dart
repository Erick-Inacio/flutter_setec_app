
import 'package:logger/logger.dart';
import 'package:setec_app/core/classes/app_exception_class.dart';
import 'package:setec_app/core/classes/result_class.dart';
import 'package:dio/dio.dart';
import 'package:setec_app/data/core/base_routes.dart';
import 'package:setec_app/data/firebase/auth/firebase_email_repository.dart';

abstract class BaseService<T> {
  BaseService({
    required this.apiRoute,
    required this.fromJson,
    required this.toJson,
  });

  final BaseRoutes apiRoute;
  final T Function(Map<String, dynamic>) fromJson;
  final Map<String, dynamic> Function(T) toJson;

  // final auth = FirebaseEmailReapository();

  final Dio _dio = Dio();

  //Métodos https genéricos
  //Get all
  Future<Result<List<T>>> getAll() async {
    return handleResult(() async {
      final result = await getAuthHeaders();

      switch (result) {
        case Ok(value: final header):
          final response = await _dio.get(
            apiRoute.getAll(),
            options: Options(
              headers: header,
            ),
          );
        final data = response.data as List;
          if(data.isEmpty || data == []) return [];
          return data.map((e) => fromJson(e)).toList();
        case Error(error: final e):
          throw e;
      }
    });
  }
  Future<Result<List<T>>> getAllPaged({int lastId = 1, int size = 10}) async {
    return handleResult(() async {
      final result = await getAuthHeaders();

      switch (result) {
        case Ok(value: final header):
          final response = await _dio.get(
            apiRoute.getAllPaged(),
            queryParameters: {
              'lastId': lastId,
              'size': size,
            },
            options: Options(
              headers: header,
            ),
          );
          final data = response.data as List;
          return data.map((e) => fromJson(e)).toList();
        case Error(error: final e):
          throw e;
      }
    });
  }

  //Get by id
  Future<Result<T>> getById(int id) async {
    return handleResult(() async {
      final result = await getAuthHeaders();

      switch (result) {
        case Ok(value: final header):
          final response = await _dio.get(
            apiRoute.getById(id),
            options: Options(
              headers: header,
            ),
          );
          final data = response.data as Map<String, dynamic>;
          return fromJson(data);
        case Error(error: final e):
          throw e;
      }
    });
  }

  //Post
  Future<Result<T>> post(T t) async {
    return handleResult(() async {
      final result = await getAuthHeaders();

      Map<String, dynamic> data = {};
      switch (result) {
        case Ok(value: final header):
          Logger().i(toJson(t));
          Logger().i(header["Authorization"]);
          final response = await _dio.post(
            apiRoute.post(),
            options: Options(
              headers: header,
            ),
            data: toJson(t),
          );

          data = response.data as Map<String, dynamic>;
          return fromJson(data);
        case Error(error: final e):
          throw e;
      }
    });
  }

  //put
  Future<Result<T>> put(T t) async {
    return handleResult(() async {
      final result = await getAuthHeaders();

      switch (result) {
        case Ok(value: final header):
          final response = await _dio.put(
            apiRoute.put(),
            options: Options(
              headers: header,
            ),
            data: toJson(t),
          );

          final data = response.data as Map<String, dynamic>;
          return fromJson(data);
        case Error(error: final e):
          throw e;
      }
    });
  }

  //delete
  Future<Result<void>> delete(int t) async {
    return handleResult(() async {
      final result = await getAuthHeaders();

      switch (result) {
        case Ok(value: final header):
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
        case Error(error: final e):
          throw e;
      }
    });
  }

  Future<Result<Map<String, String>>> getAuthHeaders() async {
    return handleResult(() async {
      final result = await FirebaseEmailReapository().getUserToken();
      switch (result) {
        case Ok(value: final token):
          return {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          };
        case Error(error: final e):
          throw e;
      }
    });
  }
}
