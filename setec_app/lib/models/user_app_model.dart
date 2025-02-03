import 'package:setec_app/utils/enums/roles.dart';

class UserApp {
  int? id;
  late String uid;
  late String name;
  late String email;
  late Roles role;
  late String ra;

  UserApp.empty();

  UserApp({
    required this.id,
    required this.uid,
    required this.name,
    required this.email,
    required this.role,
    required this.ra,
  });

  factory UserApp.fromJson(Map<String, dynamic> json) {
    int roleIndex =
        Roles.values.indexWhere((role) => role.toString() == "Roles.${json['role']}");

    return UserApp(
      id: json['id'],
      uid: json['uid'],
      name: json['name'],
      email: json['email'],
      role: Roles.values[roleIndex],
      ra: json['ra'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'uid': uid,
      'name': name,
      'email': email,
      'role': role.index,
      'ra': ra,
    };
  }

  @override
  String toString() {
    return 'UserApp{id: $id, uid: $uid, name: $name, email: $email, role: $role, ra: $ra}';
  }
}
