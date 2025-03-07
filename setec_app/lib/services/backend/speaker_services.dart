import 'dart:convert';

import 'package:setec_app/models/speaker_model.dart';
import 'package:setec_app/models/user_app_model.dart';
import 'package:setec_app/services/backend/base_service.dart';
import 'package:setec_app/services/backend/routes/speaker_routes.dart';
import 'package:setec_app/services/firebase/auth/auth_service.dart';
import 'package:http/http.dart' as http;

class SpeakerServices extends BaseService<Speaker> {
  SpeakerServices()
      : super(
          apiRoute: SpeakerRoutes(),
          fromJson: Speaker.fromJson,
          toJson: (speaker) => speaker.toJson(),
        );

  Future<Speaker?> getByUser(int userId) async {
    final routes = SpeakerRoutes();
    final token = await AuthService().getUserToken();

    if (token == null) {
      throw Exception("Failed to retrieve user token");
    }

    try {
      final response = await BaseService.sendRequest(
        () => http.get(
          Uri.parse(routes.getByUser(userId)),
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json'
          },
        ),
      );

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        final user = UserApp.fromJson(json['user']);
        final speaker = Speaker.fromJson(json);
        speaker.user = user;
        return speaker;
      } else {
        throw Exception(
          "Failed to get speaker by user: ${response.statusCode} ${response.reasonPhrase}",
        );
      }
    } on Exception catch (e) {
      throw Exception("Failed to get speaker by user: $e");
    }
  }
}
