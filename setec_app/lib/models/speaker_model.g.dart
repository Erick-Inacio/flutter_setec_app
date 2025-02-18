// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'speaker_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Speaker _$SpeakerFromJson(Map<String, dynamic> json) => Speaker(
      userApp: (json['userApp'] as num).toInt(),
      socialMedia: (json['socialMedia'] as Map<String, dynamic>).map(
        (k, e) => MapEntry($enumDecode(_$SocialMediaEnumMap, k), e as String),
      ),
      company: json['company'] as String,
      position: json['position'] as String,
      bio: json['bio'] as String,
    );

Map<String, dynamic> _$SpeakerToJson(Speaker instance) => <String, dynamic>{
      'userApp': instance.userApp,
      'company': instance.company,
      'position': instance.position,
      'bio': instance.bio,
      'socialMedia': instance.socialMedia
          .map((k, e) => MapEntry(_$SocialMediaEnumMap[k]!, e)),
    };

const _$SocialMediaEnumMap = {
  SocialMedia.facebook: 'facebook',
  SocialMedia.linkedin: 'linkedin',
  SocialMedia.instagram: 'instagram',
  SocialMedia.twitter: 'twitter',
  SocialMedia.whatsapp: 'whatsapp',
  SocialMedia.youtube: 'youtube',
  SocialMedia.telegram: 'telegram',
  SocialMedia.github: 'github',
  SocialMedia.tiktok: 'tiktok',
  SocialMedia.website: 'website',
};
