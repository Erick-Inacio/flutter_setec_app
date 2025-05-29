// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'type_activity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TypeActivity {
  int? get id;
  String? get name;
  bool? get needsSubscription;

  /// Create a copy of TypeActivity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $TypeActivityCopyWith<TypeActivity> get copyWith =>
      _$TypeActivityCopyWithImpl<TypeActivity>(
          this as TypeActivity, _$identity);

  /// Serializes this TypeActivity to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is TypeActivity &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.needsSubscription, needsSubscription) ||
                other.needsSubscription == needsSubscription));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, needsSubscription);

  @override
  String toString() {
    return 'TypeActivity(id: $id, name: $name, needsSubscription: $needsSubscription)';
  }
}

/// @nodoc
abstract mixin class $TypeActivityCopyWith<$Res> {
  factory $TypeActivityCopyWith(
          TypeActivity value, $Res Function(TypeActivity) _then) =
      _$TypeActivityCopyWithImpl;
  @useResult
  $Res call({int? id, String? name, bool? needsSubscription});
}

/// @nodoc
class _$TypeActivityCopyWithImpl<$Res> implements $TypeActivityCopyWith<$Res> {
  _$TypeActivityCopyWithImpl(this._self, this._then);

  final TypeActivity _self;
  final $Res Function(TypeActivity) _then;

  /// Create a copy of TypeActivity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? needsSubscription = freezed,
  }) {
    return _then(_self.copyWith(
      id: freezed == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      name: freezed == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      needsSubscription: freezed == needsSubscription
          ? _self.needsSubscription
          : needsSubscription // ignore: cast_nullable_to_non_nullable
              as bool?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _TypeActivity implements TypeActivity {
  _TypeActivity({this.id, this.name, this.needsSubscription});
  factory _TypeActivity.fromJson(Map<String, dynamic> json) =>
      _$TypeActivityFromJson(json);

  @override
  final int? id;
  @override
  final String? name;
  @override
  final bool? needsSubscription;

  /// Create a copy of TypeActivity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$TypeActivityCopyWith<_TypeActivity> get copyWith =>
      __$TypeActivityCopyWithImpl<_TypeActivity>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$TypeActivityToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _TypeActivity &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.needsSubscription, needsSubscription) ||
                other.needsSubscription == needsSubscription));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, needsSubscription);

  @override
  String toString() {
    return 'TypeActivity(id: $id, name: $name, needsSubscription: $needsSubscription)';
  }
}

/// @nodoc
abstract mixin class _$TypeActivityCopyWith<$Res>
    implements $TypeActivityCopyWith<$Res> {
  factory _$TypeActivityCopyWith(
          _TypeActivity value, $Res Function(_TypeActivity) _then) =
      __$TypeActivityCopyWithImpl;
  @override
  @useResult
  $Res call({int? id, String? name, bool? needsSubscription});
}

/// @nodoc
class __$TypeActivityCopyWithImpl<$Res>
    implements _$TypeActivityCopyWith<$Res> {
  __$TypeActivityCopyWithImpl(this._self, this._then);

  final _TypeActivity _self;
  final $Res Function(_TypeActivity) _then;

  /// Create a copy of TypeActivity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? needsSubscription = freezed,
  }) {
    return _then(_TypeActivity(
      id: freezed == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      name: freezed == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      needsSubscription: freezed == needsSubscription
          ? _self.needsSubscription
          : needsSubscription // ignore: cast_nullable_to_non_nullable
              as bool?,
    ));
  }
}

// dart format on
