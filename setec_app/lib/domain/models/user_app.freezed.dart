// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_app.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$UserApp {
  int? get id;
  String get uid;
  String get name;
  String get email;
  String? get ra;
  Roles get role;
  Relationship get relationship;

  /// Create a copy of UserApp
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $UserAppCopyWith<UserApp> get copyWith =>
      _$UserAppCopyWithImpl<UserApp>(this as UserApp, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is UserApp &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.uid, uid) || other.uid == uid) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.ra, ra) || other.ra == ra) &&
            (identical(other.role, role) || other.role == role) &&
            (identical(other.relationship, relationship) ||
                other.relationship == relationship));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, id, uid, name, email, ra, role, relationship);

  @override
  String toString() {
    return 'UserApp(id: $id, uid: $uid, name: $name, email: $email, ra: $ra, role: $role, relationship: $relationship)';
  }
}

/// @nodoc
abstract mixin class $UserAppCopyWith<$Res> {
  factory $UserAppCopyWith(UserApp value, $Res Function(UserApp) _then) =
      _$UserAppCopyWithImpl;
  @useResult
  $Res call(
      {int? id,
      String uid,
      String name,
      String email,
      String? ra,
      Roles role,
      Relationship relationship});
}

/// @nodoc
class _$UserAppCopyWithImpl<$Res> implements $UserAppCopyWith<$Res> {
  _$UserAppCopyWithImpl(this._self, this._then);

  final UserApp _self;
  final $Res Function(UserApp) _then;

  /// Create a copy of UserApp
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? uid = null,
    Object? name = null,
    Object? email = null,
    Object? ra = freezed,
    Object? role = null,
    Object? relationship = null,
  }) {
    return _then(_self.copyWith(
      id: freezed == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      uid: null == uid
          ? _self.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _self.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      ra: freezed == ra
          ? _self.ra
          : ra // ignore: cast_nullable_to_non_nullable
              as String?,
      role: null == role
          ? _self.role
          : role // ignore: cast_nullable_to_non_nullable
              as Roles,
      relationship: null == relationship
          ? _self.relationship
          : relationship // ignore: cast_nullable_to_non_nullable
              as Relationship,
    ));
  }
}

/// @nodoc

class _UserApp implements UserApp {
  const _UserApp(
      {this.id,
      required this.uid,
      required this.name,
      required this.email,
      required this.ra,
      required this.role,
      required this.relationship});

  @override
  final int? id;
  @override
  final String uid;
  @override
  final String name;
  @override
  final String email;
  @override
  final String? ra;
  @override
  final Roles role;
  @override
  final Relationship relationship;

  /// Create a copy of UserApp
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$UserAppCopyWith<_UserApp> get copyWith =>
      __$UserAppCopyWithImpl<_UserApp>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _UserApp &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.uid, uid) || other.uid == uid) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.ra, ra) || other.ra == ra) &&
            (identical(other.role, role) || other.role == role) &&
            (identical(other.relationship, relationship) ||
                other.relationship == relationship));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, id, uid, name, email, ra, role, relationship);

  @override
  String toString() {
    return 'UserApp(id: $id, uid: $uid, name: $name, email: $email, ra: $ra, role: $role, relationship: $relationship)';
  }
}

/// @nodoc
abstract mixin class _$UserAppCopyWith<$Res> implements $UserAppCopyWith<$Res> {
  factory _$UserAppCopyWith(_UserApp value, $Res Function(_UserApp) _then) =
      __$UserAppCopyWithImpl;
  @override
  @useResult
  $Res call(
      {int? id,
      String uid,
      String name,
      String email,
      String? ra,
      Roles role,
      Relationship relationship});
}

/// @nodoc
class __$UserAppCopyWithImpl<$Res> implements _$UserAppCopyWith<$Res> {
  __$UserAppCopyWithImpl(this._self, this._then);

  final _UserApp _self;
  final $Res Function(_UserApp) _then;

  /// Create a copy of UserApp
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = freezed,
    Object? uid = null,
    Object? name = null,
    Object? email = null,
    Object? ra = freezed,
    Object? role = null,
    Object? relationship = null,
  }) {
    return _then(_UserApp(
      id: freezed == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      uid: null == uid
          ? _self.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _self.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      ra: freezed == ra
          ? _self.ra
          : ra // ignore: cast_nullable_to_non_nullable
              as String?,
      role: null == role
          ? _self.role
          : role // ignore: cast_nullable_to_non_nullable
              as Roles,
      relationship: null == relationship
          ? _self.relationship
          : relationship // ignore: cast_nullable_to_non_nullable
              as Relationship,
    ));
  }
}

// dart format on
