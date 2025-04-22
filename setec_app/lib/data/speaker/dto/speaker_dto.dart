import 'package:json_annotation/json_annotation.dart';
import 'package:setec_app/core/classes/mappable_class.dart';
import 'package:setec_app/core/converters/social_media_converter.dart';
import 'package:setec_app/core/converters/user_app_converter.dart';
import 'package:setec_app/core/enums/social_media_enum.dart';
import 'package:setec_app/data/userApp/dto/user_app_dto.dart';
import 'package:setec_app/model/models/speaker.dart';

part 'speaker_dto.g.dart';

@JsonSerializable()
class SpeakerDTO implements DTOConvertible<Speaker> {
  int? id;
  String? company;
  String position;
  String bio;
  String? adminApproved;

  @UserAppConverter()
  UserAppDTO user;

  @SocialMediaConverter()
  Map<SocialMedia, String>? socialMedia;

  SpeakerDTO({
    this.id,
    this.company,
    required this.position,
    required this.bio,
    required this.user,
    this.adminApproved,
    required this.socialMedia,
  }) {
    _userFromMap();
  }

  //converte o map recebido em obj UserApp
  void _userFromMap() {
    if (user is Map<String, dynamic>) {
      user = UserAppDTO.fromJson(user as Map<String, dynamic>);
    }
  }

  factory SpeakerDTO.fromJson(Map<String, dynamic> json) =>
      _$SpeakerDTOFromJson(json);
  Map<String, dynamic> toJson() => _$SpeakerDTOToJson(this);

  /// 🔹 Adiciona um novo link de mídia social
  void addSocialMedia(SocialMedia socialMedia, String link) {
    this.socialMedia![socialMedia] = link;
  }

  @override
  Speaker toDomain() {
    return Speaker(
      id: id,
      socialMedia: socialMedia,
      company: company,
      position: position,
      bio: bio,
      adminApproved: adminApproved,
      isApproved: adminApproved != null,
      user: user.toDomain(),
    );
  }

  @override
  String toString() {
    return 'SpeakerDTO{socialMedia: $socialMedia, '
        'company: $company, position: $position, bio: $bio}';
  }
}
