import 'dart:convert';

import 'package:logger/logger.dart';
import 'package:setec_app/models/user_app_model.dart';
import 'package:setec_app/services/backend/base_service.dart';
import 'package:setec_app/services/backend/routes/user_routes.dart';
import 'package:setec_app/services/firebase/auth/auth_service.dart';

import 'package:http/http.dart' as http;

class UserServices extends BaseService<UserApp> {
    UserServices() : super(
      apiRoute: UserRoutes(),
      fromJson: (json) => UserApp.fromJson(json),
      toJson: (user) => user.toJson(),
    );

    Future<UserApp?> getByUid(String uid) async {
      UserRoutes routes = UserRoutes();
      Logger logger = Logger();
    try {
      final authService = AuthService();
      final token = await authService.getUserToken();
      logger.i('UserServices: $token');
      if (token == null) {
        throw Exception("AuthService:Failed to retrieve user token");
      }

      final response = await http.get(
        Uri.parse(routes.getByUid(uid)),
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
    } on Exception catch (e) {
      throw Exception("Failed to fetch user: $e");
    }
  }
}
