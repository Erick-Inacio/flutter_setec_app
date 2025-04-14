// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'speaker.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Speaker {
  int? get id;
  String? get company;
  String get position;
  String get bio;
  UserApp get user;
  Map<SocialMedia, String>? get socialMedia;

  /// Create a copy of Speaker
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $SpeakerCopyWith<Speaker> get copyWith =>
      _$SpeakerCopyWithImpl<Speaker>(this as Speaker, _$identity);

  /// Serializes this Speaker to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Speaker &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.company, company) || other.company == company) &&
            (identical(other.position, position) ||
                other.position == position) &&
            (identical(other.bio, bio) || other.bio == bio) &&
            (identical(other.user, user) || other.user == user) &&
            const DeepCollectionEquality()
                .equals(other.socialMedia, socialMedia));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, company, position, bio, user,
      const DeepCollectionEquality().hash(socialMedia));

  @override
  String toString() {
    return 'Speaker(id: $id, company: $company, position: $position, bio: $bio, user: $user, socialMedia: $socialMedia)';
  }
}

/// @nodoc
abstract mixin class $SpeakerCopyWith<$Res> {
  factory $SpeakerCopyWith(Speaker value, $Res Function(Speaker) _then) =
      _$SpeakerCopyWithImpl;
  @useResult
  $Res call(
      {int? id,
      String? company,
      String position,
      String bio,
      UserApp user,
      Map<SocialMedia, String>? socialMedia});

  $UserAppCopyWith<$Res> get user;
}

/// @nodoc
class _$SpeakerCopyWithImpl<$Res> implements $SpeakerCopyWith<$Res> {
  _$SpeakerCopyWithImpl(this._self, this._then);

  final Speaker _self;
  final $Res Function(Speaker) _then;

  /// Create a copy of Speaker
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? company = freezed,
    Object? position = null,
    Object? bio = null,
    Object? user = null,
    Object? socialMedia = freezed,
  }) {
    return _then(_self.copyWith(
      id: freezed == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      company: freezed == company
          ? _self.company
          : company // ignore: cast_nullable_to_non_nullable
              as String?,
      position: null == position
          ? _self.position
          : position // ignore: cast_nullable_to_non_nullable
              as String,
      bio: null == bio
          ? _self.bio
          : bio // ignore: cast_nullable_to_non_nullable
              as String,
      user: null == user
          ? _self.user
          : user // ignore: cast_nullable_to_non_nullable
              as UserApp,
      socialMedia: freezed == socialMedia
          ? _self.socialMedia
          : socialMedia // ignore: cast_nullable_to_non_nullable
              as Map<SocialMedia, String>?,
    ));
  }

  /// Create a copy of Speaker
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $UserAppCopyWith<$Res> get user {
    return $UserAppCopyWith<$Res>(_self.user, (value) {
      return _then(_self.copyWith(user: value));
    });
  }
}

/// @nodoc
@JsonSerializable()
class _Speaker implements Speaker {
  const _Speaker(
      {this.id,
      required this.company,
      required this.position,
      required this.bio,
      required this.user,
      required final Map<SocialMedia, String>? socialMedia})
      : _socialMedia = socialMedia;
  factory _Speaker.fromJson(Map<String, dynamic> json) =>
      _$SpeakerFromJson(json);

  @override
  final int? id;
  @override
  final String? company;
  @override
  final String position;
  @override
  final String bio;
  @override
  final UserApp user;
  final Map<SocialMedia, String>? _socialMedia;
  @override
  Map<SocialMedia, String>? get socialMedia {
    final value = _socialMedia;
    if (value == null) return null;
    if (_socialMedia is EqualUnmodifiableMapView) return _socialMedia;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  /// Create a copy of Speaker
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$SpeakerCopyWith<_Speaker> get copyWith =>
      __$SpeakerCopyWithImpl<_Speaker>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$SpeakerToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Speaker &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.company, company) || other.company == company) &&
            (identical(other.position, position) ||
                other.position == position) &&
            (identical(other.bio, bio) || other.bio == bio) &&
            (identical(other.user, user) || other.user == user) &&
            const DeepCollectionEquality()
                .equals(other._socialMedia, _socialMedia));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, company, position, bio, user,
      const DeepCollectionEquality().hash(_socialMedia));

  @override
  String toString() {
    return 'Speaker(id: $id, company: $company, position: $position, bio: $bio, user: $user, socialMedia: $socialMedia)';
  }
}

/// @nodoc
abstract mixin class _$SpeakerCopyWith<$Res> implements $SpeakerCopyWith<$Res> {
  factory _$SpeakerCopyWith(_Speaker value, $Res Function(_Speaker) _then) =
      __$SpeakerCopyWithImpl;
  @override
  @useResult
  $Res call(
      {int? id,
      String? company,
      String position,
      String bio,
      UserApp user,
      Map<SocialMedia, String>? socialMedia});

  @override
  $UserAppCopyWith<$Res> get user;
}

/// @nodoc
class __$SpeakerCopyWithImpl<$Res> implements _$SpeakerCopyWith<$Res> {
  __$SpeakerCopyWithImpl(this._self, this._then);

  final _Speaker _self;
  final $Res Function(_Speaker) _then;

  /// Create a copy of Speaker
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = freezed,
    Object? company = freezed,
    Object? position = null,
    Object? bio = null,
    Object? user = null,
    Object? socialMedia = freezed,
  }) {
    return _then(_Speaker(
      id: freezed == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      company: freezed == company
          ? _self.company
          : company // ignore: cast_nullable_to_non_nullable
              as String?,
      position: null == position
          ? _self.position
          : position // ignore: cast_nullable_to_non_nullable
              as String,
      bio: null == bio
          ? _self.bio
          : bio // ignore: cast_nullable_to_non_nullable
              as String,
      user: null == user
          ? _self.user
          : user // ignore: cast_nullable_to_non_nullable
              as UserApp,
      socialMedia: freezed == socialMedia
          ? _self._socialMedia
          : socialMedia // ignore: cast_nullable_to_non_nullable
              as Map<SocialMedia, String>?,
    ));
  }

  /// Create a copy of Speaker
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $UserAppCopyWith<$Res> get user {
    return $UserAppCopyWith<$Res>(_self.user, (value) {
      return _then(_self.copyWith(user: value));
    });
  }
}

// dart format on
