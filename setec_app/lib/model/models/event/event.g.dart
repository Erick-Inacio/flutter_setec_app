// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Event _$EventFromJson(Map<String, dynamic> json) => _Event(
      id: (json['id'] as num?)?.toInt(),
      initialDateTime: json['initialDateTime'] == null
          ? null
          : DateTime.parse(json['initialDateTime'] as String),
      finalDateTime: json['finalDateTime'] == null
          ? null
          : DateTime.parse(json['finalDateTime'] as String),
      name: json['name'] as String?,
    );

Map<String, dynamic> _$EventToJson(_Event instance) => <String, dynamic>{
      'id': instance.id,
      'initialDateTime': instance.initialDateTime?.toIso8601String(),
      'finalDateTime': instance.finalDateTime?.toIso8601String(),
      'name': instance.name,
    };
