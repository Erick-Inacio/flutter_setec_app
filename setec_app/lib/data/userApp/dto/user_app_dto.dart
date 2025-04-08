import 'package:json_annotation/json_annotation.dart';
import 'package:setec_app/core/enums/relationship.dart';
import 'package:setec_app/core/enums/roles.dart';

part 'user_app_dto.g.dart';

@JsonSerializable()
class UserAppDTO {
  int? id;
  late String uid;
  late String name;
  late String email;
  late String? ra;

  late Roles role;
  
  late Relationship relationship;

  UserAppDTO.empty();

  UserAppDTO({
    this.id,
    required this.uid,
    required this.name,
    required this.email,
    required this.relationship,
    required this.role,
    required this.ra,
  });

  factory UserAppDTO.fromJson(Map<String, dynamic> json) => _$UserAppDTOFromJson(json);
  Map<String, dynamic> toJson() => _$UserAppDTOToJson(this);

  @override
  String toString() {
    return 'UserAppDTO{id: $id, uid: $uid, name: $name, email: $email, '
        'role: $role, ra: $ra, relationship: $relationship}';
  }
}
