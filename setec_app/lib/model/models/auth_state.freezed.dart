// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'auth_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AuthState {
  bool get isAuthenticated;
  dynamic get user;
  bool get isUserApp;
  bool get isSpeaker;
  bool get isAdmin;
  bool get isCommission;
  bool get isStudant;
  Relationship get relationship;

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $AuthStateCopyWith<AuthState> get copyWith =>
      _$AuthStateCopyWithImpl<AuthState>(this as AuthState, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is AuthState &&
            (identical(other.isAuthenticated, isAuthenticated) ||
                other.isAuthenticated == isAuthenticated) &&
            const DeepCollectionEquality().equals(other.user, user) &&
            (identical(other.isUserApp, isUserApp) ||
                other.isUserApp == isUserApp) &&
            (identical(other.isSpeaker, isSpeaker) ||
                other.isSpeaker == isSpeaker) &&
            (identical(other.isAdmin, isAdmin) || other.isAdmin == isAdmin) &&
            (identical(other.isCommission, isCommission) ||
                other.isCommission == isCommission) &&
            (identical(other.isStudant, isStudant) ||
                other.isStudant == isStudant) &&
            (identical(other.relationship, relationship) ||
                other.relationship == relationship));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      isAuthenticated,
      const DeepCollectionEquality().hash(user),
      isUserApp,
      isSpeaker,
      isAdmin,
      isCommission,
      isStudant,
      relationship);

  @override
  String toString() {
    return 'AuthState(isAuthenticated: $isAuthenticated, user: $user, isUserApp: $isUserApp, isSpeaker: $isSpeaker, isAdmin: $isAdmin, isCommission: $isCommission, isStudant: $isStudant, relationship: $relationship)';
  }
}

/// @nodoc
abstract mixin class $AuthStateCopyWith<$Res> {
  factory $AuthStateCopyWith(AuthState value, $Res Function(AuthState) _then) =
      _$AuthStateCopyWithImpl;
  @useResult
  $Res call(
      {bool isAuthenticated,
      dynamic user,
      bool isUserApp,
      bool isSpeaker,
      bool isAdmin,
      bool isCommission,
      bool isStudant,
      Relationship relationship});
}

/// @nodoc
class _$AuthStateCopyWithImpl<$Res> implements $AuthStateCopyWith<$Res> {
  _$AuthStateCopyWithImpl(this._self, this._then);

  final AuthState _self;
  final $Res Function(AuthState) _then;

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isAuthenticated = null,
    Object? user = freezed,
    Object? isUserApp = null,
    Object? isSpeaker = null,
    Object? isAdmin = null,
    Object? isCommission = null,
    Object? isStudant = null,
    Object? relationship = null,
  }) {
    return _then(_self.copyWith(
      isAuthenticated: null == isAuthenticated
          ? _self.isAuthenticated
          : isAuthenticated // ignore: cast_nullable_to_non_nullable
              as bool,
      user: freezed == user
          ? _self.user
          : user // ignore: cast_nullable_to_non_nullable
              as dynamic,
      isUserApp: null == isUserApp
          ? _self.isUserApp
          : isUserApp // ignore: cast_nullable_to_non_nullable
              as bool,
      isSpeaker: null == isSpeaker
          ? _self.isSpeaker
          : isSpeaker // ignore: cast_nullable_to_non_nullable
              as bool,
      isAdmin: null == isAdmin
          ? _self.isAdmin
          : isAdmin // ignore: cast_nullable_to_non_nullable
              as bool,
      isCommission: null == isCommission
          ? _self.isCommission
          : isCommission // ignore: cast_nullable_to_non_nullable
              as bool,
      isStudant: null == isStudant
          ? _self.isStudant
          : isStudant // ignore: cast_nullable_to_non_nullable
              as bool,
      relationship: null == relationship
          ? _self.relationship
          : relationship // ignore: cast_nullable_to_non_nullable
              as Relationship,
    ));
  }
}

/// @nodoc

class _AuthState implements AuthState {
  const _AuthState(
      {required this.isAuthenticated,
      required this.user,
      required this.isUserApp,
      required this.isSpeaker,
      required this.isAdmin,
      required this.isCommission,
      required this.isStudant,
      required this.relationship});

  @override
  final bool isAuthenticated;
  @override
  final dynamic user;
  @override
  final bool isUserApp;
  @override
  final bool isSpeaker;
  @override
  final bool isAdmin;
  @override
  final bool isCommission;
  @override
  final bool isStudant;
  @override
  final Relationship relationship;

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$AuthStateCopyWith<_AuthState> get copyWith =>
      __$AuthStateCopyWithImpl<_AuthState>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _AuthState &&
            (identical(other.isAuthenticated, isAuthenticated) ||
                other.isAuthenticated == isAuthenticated) &&
            const DeepCollectionEquality().equals(other.user, user) &&
            (identical(other.isUserApp, isUserApp) ||
                other.isUserApp == isUserApp) &&
            (identical(other.isSpeaker, isSpeaker) ||
                other.isSpeaker == isSpeaker) &&
            (identical(other.isAdmin, isAdmin) || other.isAdmin == isAdmin) &&
            (identical(other.isCommission, isCommission) ||
                other.isCommission == isCommission) &&
            (identical(other.isStudant, isStudant) ||
                other.isStudant == isStudant) &&
            (identical(other.relationship, relationship) ||
                other.relationship == relationship));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      isAuthenticated,
      const DeepCollectionEquality().hash(user),
      isUserApp,
      isSpeaker,
      isAdmin,
      isCommission,
      isStudant,
      relationship);

  @override
  String toString() {
    return 'AuthState(isAuthenticated: $isAuthenticated, user: $user, isUserApp: $isUserApp, isSpeaker: $isSpeaker, isAdmin: $isAdmin, isCommission: $isCommission, isStudant: $isStudant, relationship: $relationship)';
  }
}

/// @nodoc
abstract mixin class _$AuthStateCopyWith<$Res>
    implements $AuthStateCopyWith<$Res> {
  factory _$AuthStateCopyWith(
          _AuthState value, $Res Function(_AuthState) _then) =
      __$AuthStateCopyWithImpl;
  @override
  @useResult
  $Res call(
      {bool isAuthenticated,
      dynamic user,
      bool isUserApp,
      bool isSpeaker,
      bool isAdmin,
      bool isCommission,
      bool isStudant,
      Relationship relationship});
}

/// @nodoc
class __$AuthStateCopyWithImpl<$Res> implements _$AuthStateCopyWith<$Res> {
  __$AuthStateCopyWithImpl(this._self, this._then);

  final _AuthState _self;
  final $Res Function(_AuthState) _then;

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? isAuthenticated = null,
    Object? user = freezed,
    Object? isUserApp = null,
    Object? isSpeaker = null,
    Object? isAdmin = null,
    Object? isCommission = null,
    Object? isStudant = null,
    Object? relationship = null,
  }) {
    return _then(_AuthState(
      isAuthenticated: null == isAuthenticated
          ? _self.isAuthenticated
          : isAuthenticated // ignore: cast_nullable_to_non_nullable
              as bool,
      user: freezed == user
          ? _self.user
          : user // ignore: cast_nullable_to_non_nullable
              as dynamic,
      isUserApp: null == isUserApp
          ? _self.isUserApp
          : isUserApp // ignore: cast_nullable_to_non_nullable
              as bool,
      isSpeaker: null == isSpeaker
          ? _self.isSpeaker
          : isSpeaker // ignore: cast_nullable_to_non_nullable
              as bool,
      isAdmin: null == isAdmin
          ? _self.isAdmin
          : isAdmin // ignore: cast_nullable_to_non_nullable
              as bool,
      isCommission: null == isCommission
          ? _self.isCommission
          : isCommission // ignore: cast_nullable_to_non_nullable
              as bool,
      isStudant: null == isStudant
          ? _self.isStudant
          : isStudant // ignore: cast_nullable_to_non_nullable
              as bool,
      relationship: null == relationship
          ? _self.relationship
          : relationship // ignore: cast_nullable_to_non_nullable
              as Relationship,
    ));
  }
}

// dart format on
