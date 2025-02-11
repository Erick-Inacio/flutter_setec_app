import 'package:setec_app/models/user_app_model.dart';
import 'package:setec_app/utils/enums/social_media_enum.dart';

class Speaker {
  late UserApp userApp;
  late String company;
  late String position;
  late String bio;
  late Map<SocialMedia, String> socialMedia;

  Speaker({
    required this.userApp,
    required this.socialMedia,
    required this.company,
    required this.position,
    required this.bio,
  });

  /// 🔹 Converte JSON em um `Speaker`
  factory Speaker.fromJson(Map<String, dynamic> json) {
    return Speaker(
      userApp: UserApp.fromJson(json['userApp']), // Acessando corretamente
      socialMedia: (json['socialMedia'] as Map<String, dynamic>).map(
        (key, value) => MapEntry(SocialMedia.fromString(key)!, value.toString()),
      ),
      company: json['company'] ?? '',
      position: json['position'] ?? '',
      bio: json['bio'] ?? '',
    );
  }

  /// 🔹 Converte `Speaker` em JSON
  Map<String, dynamic> toJson() {
    return {
      'userApp': userApp.toJson(),
      'socialMedia': socialMedia.map((key, value) => MapEntry(key.name, value)),
      'company': company,
      'position': position,
      'bio': bio,
    };
  }

  /// 🔹 Adiciona um novo link de mídia social
  void addSocialMedia(SocialMedia socialMedia, String link) {
    this.socialMedia[socialMedia] = link;
  }

  @override
  String toString() {
    return 'Speaker{userApp: ${userApp.toString()}, socialMedia: $socialMedia, '
        'company: $company, position: $position, bio: $bio}';
  }
}
