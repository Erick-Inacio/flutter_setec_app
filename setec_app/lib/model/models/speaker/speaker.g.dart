// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'speaker.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Speaker _$SpeakerFromJson(Map<String, dynamic> json) => _Speaker(
      id: (json['id'] as num?)?.toInt(),
      user: UserApp.fromJson(json['user'] as Map<String, dynamic>),
      company: json['company'] as String?,
      position: json['position'] as String,
      bio: json['bio'] as String,
      isApproved: json['isApproved'] as bool?,
      adminUid: json['adminUid'] as String?,
      socialMedia: (json['socialMedia'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry($enumDecode(_$SocialMediaEnumMap, k), e as String),
      ),
    );

Map<String, dynamic> _$SpeakerToJson(_Speaker instance) => <String, dynamic>{
      'id': instance.id,
      'user': instance.user,
      'company': instance.company,
      'position': instance.position,
      'bio': instance.bio,
      'isApproved': instance.isApproved,
      'adminUid': instance.adminUid,
      'socialMedia': instance.socialMedia
          ?.map((k, e) => MapEntry(_$SocialMediaEnumMap[k]!, e)),
    };

const _$SocialMediaEnumMap = {
  SocialMedia.facebook: 'FACEBOOK',
  SocialMedia.linkedin: 'LINKEDIN',
  SocialMedia.instagram: 'INSTAGRAM',
  SocialMedia.twitter: 'TWITTER',
  SocialMedia.whatsapp: 'WHATSAPP',
  SocialMedia.youtube: 'YOUTUBE',
  SocialMedia.telegram: 'TELEGRAM',
  SocialMedia.github: 'GITHUB',
  SocialMedia.tiktok: 'TIKTOK',
  SocialMedia.website: 'WEBSITE',
};
