import 'package:firebase_auth/firebase_auth.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:setec_app/core/classes/mappable_class.dart';
import 'package:setec_app/core/enums/relationship.dart';
import 'package:setec_app/core/enums/roles.dart';
import 'package:setec_app/domain/models/user_app.dart';

part 'user_app_dto.g.dart';

@JsonSerializable()
class UserAppDTO implements DTOConvertible<UserApp> {
  int? id;
  late String uid;
  late String? name;
  late String email;
  late String? ra;

  late Roles? role;

  late Relationship? relationship;

  UserAppDTO.empty();

  UserAppDTO({
    this.id,
    required this.uid,
    this.name,
    required this.email,
    this.relationship,
    this.role,
    this.ra,
  });

  factory UserAppDTO.fromFirebase(User user) {
    return UserAppDTO(
      uid: user.uid,
      email: user.email ?? '',
      name: user.displayName, // pode vir null
    );
  }

  factory UserAppDTO.fromJson(Map<String, dynamic> json) =>
      _$UserAppDTOFromJson(json);
  Map<String, dynamic> toJson() => _$UserAppDTOToJson(this);

  @override
  UserApp toDomain() {
    return UserApp(
      id: id,
      uid: uid,
      name: name!,
      email: email,
      role: role!,
      ra: ra,
      relationship: relationship!,
    );
  }

  @override
  String toString() {
    return 'UserAppDTO{id: $id, uid: $uid, name: $name, email: $email, '
        'role: $role, ra: $ra, relationship: $relationship}';
  }
}
