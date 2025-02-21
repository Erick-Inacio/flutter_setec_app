import 'package:json_annotation/json_annotation.dart';
import 'package:setec_app/models/user_app_model.dart';
import 'package:setec_app/utils/enums/relationship.dart';
import 'package:setec_app/utils/enums/roles.dart';

class UserAppConverter implements JsonConverter<UserApp, Map<String, dynamic>> {
  const UserAppConverter();

  @override
  UserApp fromJson(Map<String, dynamic> json) {
    final user = json['user'];

    return UserApp(
      id: user['id'],
      uid: user['uid'],
      name: user['name'],
      email: user['email'],
      role: Roles.fromString(user['role']),
      ra: user['ra'],
      relationship: Relationship.fromString(
        user['relationship'],
      ),
    );
  }

  @override
  Map<String, dynamic> toJson(UserApp userApp) => userApp.toJson();
}
