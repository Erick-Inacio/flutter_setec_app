import 'package:json_annotation/json_annotation.dart';
import 'package:setec_app/utils/enums/relationship.dart';
import 'package:setec_app/utils/enums/roles.dart';

part 'user_app_model.g.dart';

@JsonSerializable()
class UserApp {
  int? id;
  late String uid;
  late String name;
  late String email;
  late String? ra;

  late Roles role;
  
  late Relationship relationship;

  UserApp.empty();

  UserApp({
    this.id,
    required this.uid,
    required this.name,
    required this.email,
    required this.relationship,
    required this.role,
    required this.ra,
  });

  factory UserApp.fromJson(Map<String, dynamic> json) => _$UserAppFromJson(json);
  Map<String, dynamic> toJson() => _$UserAppToJson(this);

  @override
  String toString() {
    return 'UserApp{id: $id, uid: $uid, name: $name, email: $email, '
        'role: $role, ra: $ra, relationship: $relationship}';
  }
}
