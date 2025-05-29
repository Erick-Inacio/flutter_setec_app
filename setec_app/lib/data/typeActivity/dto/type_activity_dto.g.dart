// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'type_activity_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TypeActivityDTO _$TypeActivityDTOFromJson(Map<String, dynamic> json) =>
    TypeActivityDTO(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      needsSubscription: json['needsSubscription'] as bool?,
    );

Map<String, dynamic> _$TypeActivityDTOToJson(TypeActivityDTO instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'needsSubscription': instance.needsSubscription,
    };
