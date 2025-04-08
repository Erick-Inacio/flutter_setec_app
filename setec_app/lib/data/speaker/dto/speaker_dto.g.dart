// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'speaker_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SpeakerDTO _$SpeakerDTOFromJson(Map<String, dynamic> json) => SpeakerDTO(
      id: (json['id'] as num?)?.toInt(),
      user: json['user'],
      socialMedia: const SocialMediaConverter().fromJson(json['socialMedia']),
      company: json['company'] as String,
      position: json['position'] as String,
      bio: json['bio'] as String,
    );

Map<String, dynamic> _$SpeakerDTOToJson(SpeakerDTO instance) =>
    <String, dynamic>{
      'id': instance.id,
      'company': instance.company,
      'position': instance.position,
      'bio': instance.bio,
      'user': instance.user,
      'socialMedia': const SocialMediaConverter().toJson(instance.socialMedia),
    };
