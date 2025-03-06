import 'package:json_annotation/json_annotation.dart';
import 'package:setec_app/models/user_app_model.dart';
import 'package:setec_app/utils/enums/relationship.dart';
import 'package:setec_app/utils/enums/roles.dart';

class UserAppConverter implements JsonConverter<UserApp, dynamic> {
  const UserAppConverter();

  @override
  UserApp fromJson(dynamic json) {
    if (json is Map<String, dynamic>) {

      return UserApp(
        id: json['id'],
        uid: json['uid'],
        name: json['name'],
        email: json['email'],
        role: Roles.fromString(json['role']),
        ra: json['ra'],
        relationship: Relationship.fromString(
          json['relationship'],
        ),
      );
    }
    throw Exception('Invalid JSON format');
  }

  @override
  Map<String, dynamic> toJson(UserApp userApp) => userApp.toJson();
}
