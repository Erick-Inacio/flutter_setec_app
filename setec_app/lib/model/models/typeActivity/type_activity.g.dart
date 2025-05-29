// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'type_activity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TypeActivity _$TypeActivityFromJson(Map<String, dynamic> json) =>
    _TypeActivity(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      needsSubscription: json['needsSubscription'] as bool?,
    );

Map<String, dynamic> _$TypeActivityToJson(_TypeActivity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'needsSubscription': instance.needsSubscription,
    };
