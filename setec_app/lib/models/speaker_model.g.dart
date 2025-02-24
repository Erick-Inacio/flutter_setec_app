// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'speaker_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Speaker _$SpeakerFromJson(Map<String, dynamic> json) => Speaker(
      user: const UserAppConverter().fromJson(json['user']),
      socialMedia: const SocialMediaConverter().fromJson(json['socialMedia']),
      company: json['company'] as String,
      position: json['position'] as String,
      bio: json['bio'] as String,
    );

Map<String, dynamic> _$SpeakerToJson(Speaker instance) => <String, dynamic>{
      'company': instance.company,
      'position': instance.position,
      'bio': instance.bio,
      'socialMedia': const SocialMediaConverter().toJson(instance.socialMedia),
      'user': const UserAppConverter().toJson(instance.user),
    };
