import 'dart:convert';
import 'dart:io';
import 'package:logger/logger.dart';
import 'package:setec_app/models/user_app_model.dart';
import 'package:http/http.dart' as http;
import 'package:setec_app/services/firebase/auth/auth_service.dart';
import 'package:setec_app/services/routes/api/user_route.dart';

class UserServices {
  static Future<UserApp?> createUser(UserApp userApp) async {
    AuthService auth = AuthService();
    try {
      String? token = await auth.getUserToken();
      if (token != null) {
        final response = await http.post(
          Uri.parse(UserRoutes.post),
          body: jsonEncode(userApp.toJson()),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token'
          },
        );

        if (response.statusCode == 200) {
          return UserApp.fromJson(jsonDecode(response.body));
        } else {
          return null;
        }
      }
    } on SocketException catch (e) {
      throw Exception("Erro ao conectar-se ao servidor: $e");
    } on HttpException catch (e) {
      throw Exception("Erro ao realizar a requisicao: $e");
    } on Exception catch (e) {
      throw Exception("Erro ao criar o usuario: $e");
    }
    return null;
  }

  static Future<UserApp?> getUser(String uid) async {
    Logger logger = Logger();
    try {
      final authService = AuthService();
      final token = await authService.getUserToken();
      logger.i('UserServices: $token');
      if (token == null) {
        throw Exception("AuthService:Failed to retrieve user token");
      }

      final response = await http.get(
        Uri.parse(UserRoutes.getIdByUid(uid)),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json'
        },
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        if (responseData is Map<String, dynamic> && responseData.isNotEmpty) {
          return UserApp.fromJson(responseData);
        } else {
          throw Exception("Failed to parse user data: $responseData");
        }
      } else if (response.statusCode == 404) {
        return null;
      } else {
        throw Exception("Failed to fetch user: ${response.statusCode}");
      }
    } on SocketException catch (e) {
      throw Exception("Erro ao conectar-se ao servidor: $e");
    } on HttpException catch (e) {
      throw Exception("Erro ao realizar a requisicao: $e");
    } on FormatException catch (e) {
      throw Exception("Erro ao formatar a resposta: $e");
    } on Exception catch (e) {
      throw Exception("Erro ao buscar o usuario: $e");
    }
  }

  Future<List<UserApp?>?> getAllUsers() async {
    try {
      final authService = AuthService();
      final token = await authService.getUserToken();
      if (token == null) {
        throw Exception("Failed to retrieve user token");
      }

      final response = await http.get(
        Uri.parse(UserRoutes.getAllUsers()),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json'
        },
      );
      if (response.statusCode == 200) {
        final List<dynamic> responseData = jsonDecode(response.body);
        return responseData.map((json) => UserApp.fromJson(json)).toList();
      }
    } on SocketException catch (e) {
      throw Exception("Erro ao conectar-se ao servidor: $e");
    } on HttpException catch (e) {
      throw Exception("Erro ao realizar a requisicao: $e");
    } on FormatException catch (e) {
      throw Exception("Erro ao formatar a resposta: $e");
    } on Exception catch (e) {
      throw Exception("Erro ao buscar o usuario: $e");
    }
    return null;
  }
}
