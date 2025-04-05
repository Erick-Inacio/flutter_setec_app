import 'dart:convert';

import 'package:setec_app/models/event_model.dart';
import 'package:setec_app/services/backend/base_service.dart';
import 'package:setec_app/services/backend/routes/event_routes.dart';
import 'package:setec_app/services/firebase/auth/auth_service.dart';
import 'package:http/http.dart' as http;

class EventServices extends BaseService<Event> {
  EventServices()
      : super(
          apiRoute: EventRoutes(),
          fromJson: Event.fromJson,
          toJson: (event) => event.toJson(),
        );

  Future<List<Event>> getEventsByUserId(int userId) async {
    final routes = EventRoutes();
    final token = await AuthService().getUserToken();

    if (token == null) {
      throw Exception("Failed to retrieve user token");
    }

    try {
      final response = await BaseService.sendRequest(
        () => http.get(
          Uri.parse(routes.getActivitiesByEventId(userId)),
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json'
          },
        ),
      );

      if (response.statusCode == 200) {
        List<dynamic> responseData = jsonDecode(response.body);
        return responseData
            .map((json) => Event.fromJson(
                  json,
                ))
            .toList();
      } else {
        throw Exception(
          "Failed to get event by user: ${response.statusCode} ${response.reasonPhrase}",
        );
      }
    } on Exception catch (e) {
      throw Exception("Failed to get event by user: $e");
    }
  }

  Future<List<Event>> getEventsWithNoAuth() async {
    final routes = EventRoutes();
    try {
      final response = await BaseService.sendRequest(
        () => http.get(
          Uri.parse(routes.getAll()),
          headers: {'Content-Type': 'application/json'},
        ),
      );

      if (response.statusCode == 200) {
        List<dynamic> responseData = jsonDecode(response.body);
        return responseData
            .map((json) => Event.fromJson(
                  json,
                ))
            .toList();
      } else if (response.statusCode == 204) {
        return [];
      } else {
        throw Exception(
          "Failed to get event by user: ${response.statusCode} ${response.reasonPhrase}",
        );
      }
    } on Exception catch (e) {
      throw Exception("Failed to get event by user: $e");
    }
  }
}
