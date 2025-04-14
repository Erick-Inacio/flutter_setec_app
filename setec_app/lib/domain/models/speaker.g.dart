// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'speaker.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Speaker _$SpeakerFromJson(Map<String, dynamic> json) => _Speaker(
      id: (json['id'] as num?)?.toInt(),
      company: json['company'] as String?,
      position: json['position'] as String,
      bio: json['bio'] as String,
      user: UserApp.fromJson(json['user'] as Map<String, dynamic>),
      socialMedia: (json['socialMedia'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry($enumDecode(_$SocialMediaEnumMap, k), e as String),
      ),
    );

Map<String, dynamic> _$SpeakerToJson(_Speaker instance) => <String, dynamic>{
      'id': instance.id,
      'company': instance.company,
      'position': instance.position,
      'bio': instance.bio,
      'user': instance.user,
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
