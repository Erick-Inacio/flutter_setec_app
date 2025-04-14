// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_app.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_UserApp _$UserAppFromJson(Map<String, dynamic> json) => _UserApp(
      id: (json['id'] as num?)?.toInt(),
      uid: json['uid'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      ra: json['ra'] as String?,
      role: $enumDecode(_$RolesEnumMap, json['role']),
      relationship: $enumDecode(_$RelationshipEnumMap, json['relationship']),
    );

Map<String, dynamic> _$UserAppToJson(_UserApp instance) => <String, dynamic>{
      'id': instance.id,
      'uid': instance.uid,
      'name': instance.name,
      'email': instance.email,
      'ra': instance.ra,
      'role': _$RolesEnumMap[instance.role]!,
      'relationship': _$RelationshipEnumMap[instance.relationship]!,
    };

const _$RolesEnumMap = {
  Roles.admin: 'ADMIN',
  Roles.student: 'STUDENT',
  Roles.commission: 'COMMISSION',
  Roles.speaker: 'SPEAKER',
};

const _$RelationshipEnumMap = {
  Relationship.exaluno: 'EXALUNO',
  Relationship.aluno: 'ALUNO',
  Relationship.professor: 'PROFESSOR',
  Relationship.coordenador: 'COORDENADOR',
  Relationship.semrelacao: 'SEMRELACAO',
};
