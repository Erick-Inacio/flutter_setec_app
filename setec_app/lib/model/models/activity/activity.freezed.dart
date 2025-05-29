// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'activity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Activity {
  int? get id;
  String? get name;
  TypeActivity? get typeActivity;
  Event? get event;
  int? get daysQuantity;
  int? get hoursQuantity;
  int? get qtdeVagas;

  /// Create a copy of Activity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ActivityCopyWith<Activity> get copyWith =>
      _$ActivityCopyWithImpl<Activity>(this as Activity, _$identity);

  /// Serializes this Activity to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Activity &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.typeActivity, typeActivity) ||
                other.typeActivity == typeActivity) &&
            (identical(other.event, event) || other.event == event) &&
            (identical(other.daysQuantity, daysQuantity) ||
                other.daysQuantity == daysQuantity) &&
            (identical(other.hoursQuantity, hoursQuantity) ||
                other.hoursQuantity == hoursQuantity) &&
            (identical(other.qtdeVagas, qtdeVagas) ||
                other.qtdeVagas == qtdeVagas));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, typeActivity, event,
      daysQuantity, hoursQuantity, qtdeVagas);

  @override
  String toString() {
    return 'Activity(id: $id, name: $name, typeActivity: $typeActivity, event: $event, daysQuantity: $daysQuantity, hoursQuantity: $hoursQuantity, qtdeVagas: $qtdeVagas)';
  }
}

/// @nodoc
abstract mixin class $ActivityCopyWith<$Res> {
  factory $ActivityCopyWith(Activity value, $Res Function(Activity) _then) =
      _$ActivityCopyWithImpl;
  @useResult
  $Res call(
      {int? id,
      String? name,
      TypeActivity? typeActivity,
      Event? event,
      int? daysQuantity,
      int? hoursQuantity,
      int? qtdeVagas});

  $TypeActivityCopyWith<$Res>? get typeActivity;
  $EventCopyWith<$Res>? get event;
}

/// @nodoc
class _$ActivityCopyWithImpl<$Res> implements $ActivityCopyWith<$Res> {
  _$ActivityCopyWithImpl(this._self, this._then);

  final Activity _self;
  final $Res Function(Activity) _then;

  /// Create a copy of Activity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? typeActivity = freezed,
    Object? event = freezed,
    Object? daysQuantity = freezed,
    Object? hoursQuantity = freezed,
    Object? qtdeVagas = freezed,
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
      typeActivity: freezed == typeActivity
          ? _self.typeActivity
          : typeActivity // ignore: cast_nullable_to_non_nullable
              as TypeActivity?,
      event: freezed == event
          ? _self.event
          : event // ignore: cast_nullable_to_non_nullable
              as Event?,
      daysQuantity: freezed == daysQuantity
          ? _self.daysQuantity
          : daysQuantity // ignore: cast_nullable_to_non_nullable
              as int?,
      hoursQuantity: freezed == hoursQuantity
          ? _self.hoursQuantity
          : hoursQuantity // ignore: cast_nullable_to_non_nullable
              as int?,
      qtdeVagas: freezed == qtdeVagas
          ? _self.qtdeVagas
          : qtdeVagas // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }

  /// Create a copy of Activity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $TypeActivityCopyWith<$Res>? get typeActivity {
    if (_self.typeActivity == null) {
      return null;
    }

    return $TypeActivityCopyWith<$Res>(_self.typeActivity!, (value) {
      return _then(_self.copyWith(typeActivity: value));
    });
  }

  /// Create a copy of Activity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $EventCopyWith<$Res>? get event {
    if (_self.event == null) {
      return null;
    }

    return $EventCopyWith<$Res>(_self.event!, (value) {
      return _then(_self.copyWith(event: value));
    });
  }
}

/// @nodoc
@JsonSerializable()
class _Activity implements Activity {
  _Activity(
      {this.id,
      this.name,
      this.typeActivity,
      this.event,
      this.daysQuantity,
      this.hoursQuantity,
      this.qtdeVagas});
  factory _Activity.fromJson(Map<String, dynamic> json) =>
      _$ActivityFromJson(json);

  @override
  final int? id;
  @override
  final String? name;
  @override
  final TypeActivity? typeActivity;
  @override
  final Event? event;
  @override
  final int? daysQuantity;
  @override
  final int? hoursQuantity;
  @override
  final int? qtdeVagas;

  /// Create a copy of Activity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ActivityCopyWith<_Activity> get copyWith =>
      __$ActivityCopyWithImpl<_Activity>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$ActivityToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Activity &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.typeActivity, typeActivity) ||
                other.typeActivity == typeActivity) &&
            (identical(other.event, event) || other.event == event) &&
            (identical(other.daysQuantity, daysQuantity) ||
                other.daysQuantity == daysQuantity) &&
            (identical(other.hoursQuantity, hoursQuantity) ||
                other.hoursQuantity == hoursQuantity) &&
            (identical(other.qtdeVagas, qtdeVagas) ||
                other.qtdeVagas == qtdeVagas));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, typeActivity, event,
      daysQuantity, hoursQuantity, qtdeVagas);

  @override
  String toString() {
    return 'Activity(id: $id, name: $name, typeActivity: $typeActivity, event: $event, daysQuantity: $daysQuantity, hoursQuantity: $hoursQuantity, qtdeVagas: $qtdeVagas)';
  }
}

/// @nodoc
abstract mixin class _$ActivityCopyWith<$Res>
    implements $ActivityCopyWith<$Res> {
  factory _$ActivityCopyWith(_Activity value, $Res Function(_Activity) _then) =
      __$ActivityCopyWithImpl;
  @override
  @useResult
  $Res call(
      {int? id,
      String? name,
      TypeActivity? typeActivity,
      Event? event,
      int? daysQuantity,
      int? hoursQuantity,
      int? qtdeVagas});

  @override
  $TypeActivityCopyWith<$Res>? get typeActivity;
  @override
  $EventCopyWith<$Res>? get event;
}

/// @nodoc
class __$ActivityCopyWithImpl<$Res> implements _$ActivityCopyWith<$Res> {
  __$ActivityCopyWithImpl(this._self, this._then);

  final _Activity _self;
  final $Res Function(_Activity) _then;

  /// Create a copy of Activity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? typeActivity = freezed,
    Object? event = freezed,
    Object? daysQuantity = freezed,
    Object? hoursQuantity = freezed,
    Object? qtdeVagas = freezed,
  }) {
    return _then(_Activity(
      id: freezed == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      name: freezed == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      typeActivity: freezed == typeActivity
          ? _self.typeActivity
          : typeActivity // ignore: cast_nullable_to_non_nullable
              as TypeActivity?,
      event: freezed == event
          ? _self.event
          : event // ignore: cast_nullable_to_non_nullable
              as Event?,
      daysQuantity: freezed == daysQuantity
          ? _self.daysQuantity
          : daysQuantity // ignore: cast_nullable_to_non_nullable
              as int?,
      hoursQuantity: freezed == hoursQuantity
          ? _self.hoursQuantity
          : hoursQuantity // ignore: cast_nullable_to_non_nullable
              as int?,
      qtdeVagas: freezed == qtdeVagas
          ? _self.qtdeVagas
          : qtdeVagas // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }

  /// Create a copy of Activity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $TypeActivityCopyWith<$Res>? get typeActivity {
    if (_self.typeActivity == null) {
      return null;
    }

    return $TypeActivityCopyWith<$Res>(_self.typeActivity!, (value) {
      return _then(_self.copyWith(typeActivity: value));
    });
  }

  /// Create a copy of Activity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $EventCopyWith<$Res>? get event {
    if (_self.event == null) {
      return null;
    }

    return $EventCopyWith<$Res>(_self.event!, (value) {
      return _then(_self.copyWith(event: value));
    });
  }
}

// dart format on
