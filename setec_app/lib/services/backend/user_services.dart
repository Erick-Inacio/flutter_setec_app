import 'dart:convert';
import 'dart:io';
import 'package:logger/logger.dart';
import 'package:setec_app/models/user_app_model.dart';
import 'package:http/http.dart' as http;
import 'package:setec_app/services/firebase/auth/auth_service.dart';
import 'package:setec_app/utils/routes/api/user_routes.dart';

class UserServices {
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
}
