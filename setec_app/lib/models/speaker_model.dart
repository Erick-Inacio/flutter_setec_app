// ignore_for_file: dead_code

import 'package:setec_app/models/user_app_model.dart';
import 'package:setec_app/utils/enums/roles.dart';

class Speaker extends UserApp {
  late String socialMedia;
  late String company;
  late String position;
  late String bio;

  Speaker({
    required super.id,
    required super.uid,
    required super.name,
    required super.email,
    required super.role,
    required super.ra,
    required this.socialMedia,
    required this.company,
    required this.position,
    required this.bio,
  });

  factory Speaker.fromJson(Map<String, dynamic> json) {
    return Speaker(
      id: json['id'],
      uid: json['uid'],
      name: json['name'],
      email: json['email'],
      role: Roles.values[json['role']],
      ra: json['ra'],
      socialMedia: json['socialMedia'],
      company: json['company'],
      position: json['position'],
      bio: json['bio'],
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'uid': uid,
      'name': name,
      'email': email,
      'role': role.index,
      'ra': ra,
      'socialMedia': socialMedia,
      'company': company,
      'position': position,
      'bio': bio,
    };
  }
}
