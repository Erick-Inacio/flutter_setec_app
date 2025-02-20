import 'package:json_annotation/json_annotation.dart';
import 'package:setec_app/models/user_app_model.dart';
import 'package:setec_app/utils/converters/user_app_converter.dart';
import 'package:setec_app/utils/enums/social_media_enum.dart';

part 'speaker_model.g.dart';

@JsonSerializable()
class Speaker {
  String company;
  String position;
  String bio;
  Map<SocialMedia, String> socialMedia;

  @UserAppConverter()
  UserApp user;

  Speaker({
    required this.user,
    required this.socialMedia,
    required this.company,
    required this.position,
    required this.bio,
  });

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
