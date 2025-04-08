import 'package:json_annotation/json_annotation.dart';
import 'package:setec_app/core/converters/social_media_converter.dart';
import 'package:setec_app/core/enums/social_media_enum.dart';
import 'package:setec_app/data/userApp/dto/user_app_dto.dart';

part 'speaker_dto.g.dart';

@JsonSerializable()
class SpeakerDTO {
  int? id;
  String company;
  String position;
  String bio;
  dynamic user;

  @SocialMediaConverter()
  Map<SocialMedia, String> socialMedia;

  SpeakerDTO({
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
      user = UserAppDTO.fromJson(user);
    }
  }

  factory SpeakerDTO.fromJson(Map<String, dynamic> json) =>
      _$SpeakerDTOFromJson(json);
  Map<String, dynamic> toJson() => _$SpeakerDTOToJson(this);

  /// 🔹 Adiciona um novo link de mídia social
  void addSocialMedia(SocialMedia socialMedia, String link) {
    this.socialMedia[socialMedia] = link;
  }

  @override
  String toString() {
    return 'SpeakerDTO{socialMedia: $socialMedia, '
        'company: $company, position: $position, bio: $bio}';
  }
}
