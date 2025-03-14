import 'dart:convert';
import 'dart:io';
import 'package:logger/logger.dart';
import 'package:setec_app/models/speaker_model.dart';
import 'package:setec_app/models/user_app_model.dart';
import 'package:setec_app/services/firebase/auth/auth_service.dart';

import 'package:http/http.dart' as http;
import 'package:setec_app/utils/routes/api/speaker_route.dart';

class SpeakerServices {
  static Future<List<Speaker>?> getAllSpeakers() async {
    Logger logger = Logger();
    try {
      final authService = AuthService();
      final token = await authService.getUserToken();
      if (token == null) {
        logger.e("Failed to retrieve user token");
      }

      final response = await http.get(Uri.parse(SpeakerRoutes.getAllUsers()),
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json'
          });

      if (response.statusCode == 200) {
        final List<dynamic> responseData = jsonDecode(response.body);
        return responseData.map((json) => Speaker.fromJson(json)).toList();
      }
    } on SocketException catch (e) {
      logger.e("Erro ao conectar-se ao servidor: $e");
    } on HttpException catch (e) {
      logger.e("Erro na solicitação HTTP: $e");
    } on FormatException catch (e) {
      logger.e("Formato de dados inválido: $e");
    } on Exception catch (e) {
      logger.e("Ocorreu um erro: $e");
    }
    return null;
  }

  static Future<Speaker?> getSpeakerByUserId(int userId) async {
    Logger logger = Logger();
    try {
      final authService = AuthService();
      final token = await authService.getUserToken();
      if (token == null) {
        logger.e("Failed to retrieve user token");
      }

      final response = await http.get(
        Uri.parse(SpeakerRoutes.getSpeakerByUserId(userId)),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json'
        },
      );

      if (response.statusCode == 200) {
        UserApp userApp = UserApp.fromJson(jsonDecode(response.body)['user']);
        Speaker speaker = Speaker.fromJson(jsonDecode(response.body));
        speaker.user = userApp;
        return speaker;
      }
    } catch (e) {
      logger.e("Ocorreu um erro: $e");
    }
    return null;
  }

  static Future<Speaker?> createSpeaker(Speaker speaker) async {
    Logger logger = Logger();
    try {
      final authService = AuthService();
      final token = await authService.getUserToken();
      if (token == null) {
        logger.e("Failed to retrieve user token");
      }

      final response = await http.post(
        Uri.parse(SpeakerRoutes.post),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json'
        },
        body: jsonEncode(speaker.toJson()),
      );

      if (response.statusCode == 200) {
        return Speaker.fromJson(jsonDecode(response.body));
      } else {
        return null;
      }
    } on SocketException catch (e) {
      logger.e("Erro ao conectar-se ao servidor: $e");
    } on HttpException catch (e) {
      logger.e("Erro na solicitação HTTP: $e");
    } on FormatException catch (e) {
      logger.e("Formato de dados inválido: $e");
    } on Exception catch (e) {
      logger.e("Ocorreu um erro: $e");
    }
    return null;
  }

  static Future<Speaker?> updateSpeaker(Speaker speaker) async {
    Logger logger = Logger();
    try {
      final authService = AuthService();
      final token = await authService.getUserToken();
      if (token == null) {
        logger.e("Failed to retrieve user token");
      }

      final response = await http.put(Uri.parse(SpeakerRoutes.put), headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json'
      });

      if (response.statusCode == 200) {
        return Speaker.fromJson(jsonDecode(response.body));
      } else {
        return null;
      }
    } on SocketException catch (e) {
      logger.e("Erro ao conectar-se ao servidor: $e");
    } on HttpException catch (e) {
      logger.e("Erro na solicitação HTTP: $e");
    } on FormatException catch (e) {
      logger.e("Formato de dados inválido: $e");
    } on Exception catch (e) {
      logger.e("Ocorreu um erro: $e");
    }
    return null;
  }
}
