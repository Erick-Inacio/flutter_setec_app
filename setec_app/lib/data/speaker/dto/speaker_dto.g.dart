// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'speaker_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SpeakerDTO _$SpeakerDTOFromJson(Map<String, dynamic> json) => SpeakerDTO(
      id: (json['id'] as num?)?.toInt(),
      company: json['company'] as String?,
      position: json['position'] as String,
      bio: json['bio'] as String,
      user: const UserAppConverter().fromJson(json['user']),
      adminUid: json['adminUid'] as String?,
      socialMedia: const SocialMediaConverter().fromJson(json['socialMedia']),
      isApproved: json['isApproved'] as bool?,
    );

Map<String, dynamic> _$SpeakerDTOToJson(SpeakerDTO instance) =>
    <String, dynamic>{
      'id': instance.id,
      'company': instance.company,
      'position': instance.position,
      'bio': instance.bio,
      'adminUid': instance.adminUid,
      'isApproved': instance.isApproved,
      'user': const UserAppConverter().toJson(instance.user),
      'socialMedia': _$JsonConverterToJson<dynamic, Map<SocialMedia, String>>(
          instance.socialMedia, const SocialMediaConverter().toJson),
    };

Json? _$JsonConverterToJson<Json, Value>(
  Value? value,
  Json? Function(Value value) toJson,
) =>
    value == null ? null : toJson(value);
