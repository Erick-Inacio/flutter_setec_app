// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EventDTO _$EventDTOFromJson(Map<String, dynamic> json) => EventDTO(
      id: (json['id'] as num?)?.toInt(),
      initialDateTime: DateTime.parse(json['initialDateTime'] as String),
      finalDateTime: DateTime.parse(json['finalDateTime'] as String),
      name: json['name'] as String,
    );

Map<String, dynamic> _$EventDTOToJson(EventDTO instance) => <String, dynamic>{
      'id': instance.id,
      'initialDateTime': instance.initialDateTime.toIso8601String(),
      'finalDateTime': instance.finalDateTime.toIso8601String(),
      'name': instance.name,
    };
