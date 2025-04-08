import 'package:json_annotation/json_annotation.dart';
import 'package:setec_app/core/enums/relationship.dart';
import 'package:setec_app/core/enums/roles.dart';
import 'package:setec_app/data/userApp/dto/user_app_dto.dart';

class UserAppConverter implements JsonConverter<UserAppDTO, dynamic> {
  const UserAppConverter();

  @override
  UserAppDTO fromJson(dynamic json) {
    if (json is Map<String, dynamic>) {

      return UserAppDTO(
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
  Map<String, dynamic> toJson(UserAppDTO userApp) => userApp.toJson();
}
