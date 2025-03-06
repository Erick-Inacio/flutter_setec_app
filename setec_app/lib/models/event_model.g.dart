// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Event _$EventFromJson(Map<String, dynamic> json) => Event(
      id: (json['id'] as num?)?.toInt(),
      initialDateTime: DateTime.parse(json['initialDateTime'] as String),
      finalDateTime: DateTime.parse(json['finalDateTime'] as String),
      description: json['description'] as String,
    );

Map<String, dynamic> _$EventToJson(Event instance) => <String, dynamic>{
      'id': instance.id,
      'initialDateTime': instance.initialDateTime.toIso8601String(),
      'finalDateTime': instance.finalDateTime.toIso8601String(),
      'description': instance.description,
    };
