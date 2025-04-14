// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_app_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserAppDTO _$UserAppDTOFromJson(Map<String, dynamic> json) => UserAppDTO(
      id: (json['id'] as num?)?.toInt(),
      uid: json['uid'] as String,
      name: json['name'] as String?,
      email: json['email'] as String,
      relationship:
          $enumDecodeNullable(_$RelationshipEnumMap, json['relationship']),
      role: $enumDecodeNullable(_$RolesEnumMap, json['role']),
      ra: json['ra'] as String?,
    );

Map<String, dynamic> _$UserAppDTOToJson(UserAppDTO instance) =>
    <String, dynamic>{
      'id': instance.id,
      'uid': instance.uid,
      'name': instance.name,
      'email': instance.email,
      'ra': instance.ra,
      'role': _$RolesEnumMap[instance.role],
      'relationship': _$RelationshipEnumMap[instance.relationship],
    };

const _$RelationshipEnumMap = {
  Relationship.exaluno: 'EXALUNO',
  Relationship.aluno: 'ALUNO',
  Relationship.professor: 'PROFESSOR',
  Relationship.coordenador: 'COORDENADOR',
  Relationship.semrelacao: 'SEMRELACAO',
};

const _$RolesEnumMap = {
  Roles.admin: 'ADMIN',
  Roles.student: 'STUDENT',
  Roles.commission: 'COMMISSION',
  Roles.speaker: 'SPEAKER',
};
