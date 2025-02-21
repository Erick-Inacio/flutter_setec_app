// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'speaker_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Speaker _$SpeakerFromJson(Map<String, dynamic> json) => Speaker(
      user: const UserAppConverter()
          .fromJson(json['user'] as Map<String, dynamic>),
      socialMedia: (json['socialMedia'] as Map<String, dynamic>).map(
        (k, e) => MapEntry($enumDecode(_$SocialMediaEnumMap, k), e as String),
      ),
      company: json['company'] as String,
      position: json['position'] as String,
      bio: json['bio'] as String,
    );

Map<String, dynamic> _$SpeakerToJson(Speaker instance) => <String, dynamic>{
      'company': instance.company,
      'position': instance.position,
      'bio': instance.bio,
      'socialMedia': instance.socialMedia
          .map((k, e) => MapEntry(_$SocialMediaEnumMap[k]!, e)),
      'user': const UserAppConverter().toJson(instance.user),
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
