// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'activity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Activity _$ActivityFromJson(Map<String, dynamic> json) => _Activity(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      typeActivity: json['typeActivity'] == null
          ? null
          : TypeActivity.fromJson(json['typeActivity'] as Map<String, dynamic>),
      event: json['event'] == null
          ? null
          : Event.fromJson(json['event'] as Map<String, dynamic>),
      daysQuantity: (json['daysQuantity'] as num?)?.toInt(),
      hoursQuantity: (json['hoursQuantity'] as num?)?.toInt(),
      qtdeVagas: (json['qtdeVagas'] as num?)?.toInt(),
    );

Map<String, dynamic> _$ActivityToJson(_Activity instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'typeActivity': instance.typeActivity,
      'event': instance.event,
      'daysQuantity': instance.daysQuantity,
      'hoursQuantity': instance.hoursQuantity,
      'qtdeVagas': instance.qtdeVagas,
    };
