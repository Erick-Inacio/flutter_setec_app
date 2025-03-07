import 'dart:convert';
import 'dart:io';
import 'package:setec_app/services/firebase/auth/auth_service.dart';
import 'package:http/http.dart' as http;
import 'package:setec_app/services/backend/routes/base_routes.dart';

abstract class BaseService<T> {
  final BaseRoutes apiRoute;
  final T Function(Map<String, dynamic>) fromJson;
  final Map<String, dynamic> Function(T) toJson;

  final AuthService auth = AuthService();

  BaseService({
    required this.apiRoute,
    required this.fromJson,
    required this.toJson,
  });

  //Métodos https genéricos
  //Get all
  Future<List<T>> getAll() async {
    try {
      final token = await auth.getUserToken();
      if (token == null) {
        throw Exception("Failed to retrieve user token");
      }

      final response = await sendRequest(() => http.get(
            Uri.parse(apiRoute.getAll()),
            headers: {
              'Authorization': 'Bearer $token',
              'Content-Type': 'application/json'
            },
          ));
      if (response.statusCode == 200) {
        List<dynamic> responseData = jsonDecode(response.body);
        return responseData
            .map((json) => fromJson(json))
            .where((e) => e != null)
            .toList();
      } else {
        return throw Exception(
            "Failed to delete user: ${response.statusCode} ${response.reasonPhrase}");
      }
    } on Exception catch (e) {
      throw Exception("Erro ao buscar o usuario: $e");
    }
  }

  //Get by id
  Future<T> getById(int id) async {
    try {
      final token = await auth.getUserToken();
      if (token == null) {
        throw Exception("Failed to retrieve user token");
      }

      final response = await sendRequest(() => http.get(
            Uri.parse(apiRoute.getById(id)),
            headers: {
              'Authorization': 'Bearer $token',
              'Content-Type': 'application/json'
            },
          ));
      if (response.statusCode == 200) {
        return fromJson(jsonDecode(response.body));
      } else {
        return throw Exception(
            "Failed to delete user: ${response.statusCode} ${response.reasonPhrase}");
      }
    } catch (e) {
      throw Exception("Erro ao buscar o usuario: $e");
    }
  }

  //Post
  Future<T> post(T t) async {
    try {
      final token = await auth.getUserToken();
      if (token != null) {
        final response = await sendRequest(() => http.post(
              Uri.parse(apiRoute.post()),
              headers: {
                'Content-Type': 'application/json',
                'Authorization': 'Bearer $token'
              },
              body: jsonEncode(toJson(t)),
            ));

        if (response.statusCode == 200) {
          return fromJson(jsonDecode(response.body));
        } else {
          return throw Exception(
            "Failed to create user: ${response.statusCode} ${response.reasonPhrase}",
          );
        }
      } else {
        return throw Exception("Failed to retrieve user token");
      }
    } on Exception catch (e) {
      throw Exception("Erro ao criar o usuario: $e");
    }
  }

  //put
  Future<T> put(T t) async {
    try {
      final authService = AuthService();
      final token = await authService.getUserToken();
      if (token == null) {
        throw Exception("AuthService: Failed to retrieve user token");
      }

      final response = await http.put(
        Uri.parse(apiRoute.put()),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json'
        },
        body: jsonEncode(toJson(t)),
      );

      if (response.statusCode == 200) {
        return fromJson(jsonDecode(response.body));
      } else {
        throw Exception(
            "Failed to update user: ${response.statusCode} ${response.reasonPhrase}");
      }
    } on Exception catch (e) {
      throw Exception("Failed to update user: $e");
    }
  }

  //delete
  Future<void> delete(int t) async {
    try {
      final authService = AuthService();
      final token = await authService.getUserToken();
      if (token == null) {
        throw Exception("AuthService: Failed to retrieve user token");
      }

      final response = await http.delete(
        Uri.parse(apiRoute.delete(t)),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json'
        },
      );

      if (response.statusCode == 204) {
        return;
      } else {
        throw Exception(
            "Failed to delete user: ${response.statusCode} ${response.reasonPhrase}");
      }
    } on Exception catch (e) {
      throw Exception("Failed to delete user: $e");
    }
  }

  //Personilized Methods
  static Future<http.Response> sendRequest(
    Future<http.Response> Function() request,
  ) async {
    try {
      return await request();
    } on SocketException catch (e) {
      throw Exception("Erro ao conectar-se ao servidor: $e");
    } on HttpException catch (e) {
      throw Exception("Erro na solicitação HTTP: $e");
    } on FormatException catch (e) {
      throw Exception("Formato de dados inválido: $e");
    }
  }
}
