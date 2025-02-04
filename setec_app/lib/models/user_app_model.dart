import 'package:setec_app/utils/enums/relationship.dart';
import 'package:setec_app/utils/enums/roles.dart';

class UserApp {
  int? id;
  late String uid;
  late String name;
  late String email;
  late Relationship relationship;
  late Roles role;
  late String ra;

  UserApp.empty();

  UserApp({
    required this.id,
    required this.uid,
    required this.name,
    required this.email,
    required this.relationship,
    required this.role,
    required this.ra,
  });

  factory UserApp.fromJson(Map<String, dynamic> json) {
    return UserApp(
      id: json['id'],
      uid: json['uid'],
      name: json['name'],
      email: json['email'],
      role: Roles.fromString(json['role']),
      ra: json['ra'],
      relationship: Relationship.fromString(json['relationship']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'uid': uid,
      'name': name,
      'email': email,
      'role': role.name.toUpperCase(),
      'ra': ra,
      'relationship': relationship.name.toUpperCase(),
    };
  }

  @override
  String toString() {
    return 'UserApp{id: $id, uid: $uid, name: $name, email: $email, '
        'role: $role, ra: $ra, relationship: $relationship}';
  }
}
