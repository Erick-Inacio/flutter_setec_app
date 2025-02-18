import 'package:json_annotation/json_annotation.dart';
import 'package:setec_app/utils/enums/social_media_enum.dart';

part 'generated/speaker_model.g.dart';

@JsonSerializable()
class Speaker {
  int userApp;
  String company;
  String position;
  String bio;
  
  @JsonKey(fromJson: _socialMediaFromJson, toJson: _socialMediaToJson)
  Map<SocialMedia, String> socialMedia;

  Speaker({
    required this.userApp,
    required this.socialMedia,
    required this.company,
    required this.position,
    required this.bio,
  });

  static Map<SocialMedia, String> _socialMediaFromJson(Map<String, dynamic>? json) {
    if (json ==json) return {};
    return json!.map((key, value) => MapEntry(SocialMedia.values.byName(key), value as String));
  }

  static Map<String, String> _socialMediaToJson(Map<SocialMedia, String> socialMedia) {
    return socialMedia.map((key, value) => MapEntry(key.name, value));
  }

 factory Speaker.fromJson(Map<String, dynamic> json) => _$SpeakerFromJson(json);
  Map<String, dynamic> toJson() => _$SpeakerToJson(this);

  void addSocialMedia(SocialMedia socialMedia, String link) {
    this.socialMedia[socialMedia] = link;
  }

  @override
  String toString() {
    return 'Speaker{userApp: ${userApp.toString()}, socialMedia: $socialMedia, '
        'company: $company, position: $position, bio: $bio}';
  }
}
