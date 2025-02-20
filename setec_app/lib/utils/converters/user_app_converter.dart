import 'package:json_annotation/json_annotation.dart';
import 'package:setec_app/models/user_app_model.dart';
import 'package:setec_app/utils/enums/relationship.dart';
import 'package:setec_app/utils/enums/roles.dart';

class UserAppConverter implements JsonConverter<UserApp, int> {
  const UserAppConverter();

  @override
  UserApp fromJson(dynamic json) {
    if(json is Map<String, dynamic>){
      return UserApp(
      id: json['user']['id'],
      uid: json['user']['uid'],
      name: json['user']['name'],
      email: json['user']['email'],
      role: Roles.fromString(json['user']['role']),
      ra: json['user']['ra'],
      relationship: Relationship.fromString(
        json['user']['relationship'],
      ),
    );
    }else{
      return UserApp.empty();
    }
  }

  @override
  int toJson(UserApp userApp) => userApp.id ?? 0;
}
