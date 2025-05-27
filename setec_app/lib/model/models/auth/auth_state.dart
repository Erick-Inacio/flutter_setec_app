import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:setec_app/core/enums/relationship.dart';
import 'package:setec_app/core/interface/user_wrapper_interface.dart';

part 'auth_state.freezed.dart';

@freezed
abstract class AuthState with _$AuthState {
  const factory AuthState({
    required bool isAuthenticated,
    required UserWrapper? user,
    required bool isUserApp,
    required bool isSpeaker,
    required bool isAdmin,
    required bool isCommission,
    required bool isStudant,
    required Relationship relationship,
  }) = _AuthState;

  static const AuthState initial = AuthState(
    isAuthenticated: false,
    user: null,
    isUserApp: false,
    isSpeaker: false,
    isAdmin: false,
    isCommission: false,
    isStudant: false,
    relationship: Relationship.semrelacao,
  );
}
