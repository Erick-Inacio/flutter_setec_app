// ignore_for_file: dead_code

import 'package:setec_app/models/user_app_model.dart';

class Speaker {
  late UserApp userApp;
  late String socialMedia;
  late String company;
  late String position;
  late String bio;

  Speaker({
    required this.userApp,
    required this.socialMedia,
    required this.company,
    required this.position,
    required this.bio,
  });

  factory Speaker.fromJson(Map<String, dynamic> json) {
    return Speaker(
      userApp: UserApp.fromJson(json),
      socialMedia: json['socialMedia'],
      company: json['company'],
      position: json['position'],
      bio: json['bio'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userApp': userApp.toJson(),
      'socialMedia': socialMedia,
      'company': company,
      'position': position,
      'bio': bio,
    };
  }

  @override
  String toString() {
    return 'Speaker{userApp: ${userApp.toString()}, socialMedia: $socialMedia, '
        'company: $company, position: $position, bio: $bio}';
  }
}
