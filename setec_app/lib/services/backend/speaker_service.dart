import 'dart:convert';
import 'dart:io';

import 'package:setec_app/models/speaker_model.dart';
import 'package:setec_app/services/firebase/auth/auth_service.dart';

import 'package:http/http.dart' as http;
import 'package:setec_app/services/routes/api/speaker_route.dart';

class SpeakerService {
  static Future<List<Speaker>?> getAllSpeakers() async {
    try {
      final authService = AuthService();
      final token = await authService.getUserToken();
      if (token == null) {
        throw Exception("Failed to retrieve user token");
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
      throw Exception("Erro ao conectar-se ao servidor: $e");
    } on HttpException catch (e) {
      throw Exception("Erro na solicitação HTTP: $e");
    } on FormatException catch (e) {
      throw Exception("Formato de dados inválido: $e");
    } on Exception catch (e) {
      throw Exception("Ocorreu um erro: $e");
    }
    return null;
  }

  static Future<Speaker?> createSpeaker(Speaker speaker) async {
    try {
      final authService = AuthService();
      final token = await authService.getUserToken();
      if (token == null) {
        throw Exception("Failed to retrieve user token");
      }

      final response = await http.post(
        Uri.parse(SpeakerRoutes.post),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json'
        },
      );

      if (response.statusCode == 200) {
        return Speaker.fromJson(jsonDecode(response.body));
      } else {
        return null;
      }
    } on SocketException catch (e) {
      throw Exception("Erro ao conectar-se ao servidor: $e");
    } on HttpException catch (e) {
      throw Exception("Erro na solicitação HTTP: $e");
    } on FormatException catch (e) {
      throw Exception("Formato de dados inválido: $e");
    } on Exception catch (e) {
      throw Exception("Ocorreu um erro: $e");
    }
  }

  static Future<Speaker?> updateSpeaker(Speaker speaker) async {
    try {
      final authService = AuthService();
      final token = await authService.getUserToken();
      if (token == null) {
        throw Exception("Failed to retrieve user token");
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
      throw Exception("Erro ao conectar-se ao servidor: $e");
    } on HttpException catch (e) {
      throw Exception("Erro na solicitação HTTP: $e");
    } on FormatException catch (e) {
      throw Exception("Formato de dados inválido: $e");
    } on Exception catch (e) {
      throw Exception("Ocorreu um erro: $e");
    }
  }
}
