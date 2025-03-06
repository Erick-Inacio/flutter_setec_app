import 'package:json_annotation/json_annotation.dart';
import 'package:setec_app/models/user_app_model.dart';
import 'package:setec_app/utils/converters/social_media_converter.dart';
import 'package:setec_app/utils/enums/social_media_enum.dart';

part 'speaker_model.g.dart';

@JsonSerializable()
class Speaker {
  int? id;
  String company;
  String position;
  String bio;
  dynamic user;

  @SocialMediaConverter()
  Map<SocialMedia, String> socialMedia;

  Speaker({
    this.id,
    required this.user,
    required this.socialMedia,
    required this.company,
    required this.position,
    required this.bio,
  }) {
    _userFromMap();
  }

  //converte o map recebido em obj UserApp
  void _userFromMap() {
    if (user != null && user is Map<String, dynamic>) {
      user = UserApp.fromJson(user);
    }
  }

  factory Speaker.fromJson(Map<String, dynamic> json) =>
      _$SpeakerFromJson(json);
  Map<String, dynamic> toJson() => _$SpeakerToJson(this);

  /// 🔹 Adiciona um novo link de mídia social
  void addSocialMedia(SocialMedia socialMedia, String link) {
    this.socialMedia[socialMedia] = link;
  }

  @override
  String toString() {
    return 'Speaker{socialMedia: $socialMedia, '
        'company: $company, position: $position, bio: $bio}';
  }
}
