import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:setec_app/core/enums/relationship.dart';

part 'auth_state.freezed.dart';

@freezed
abstract class AuthState with _$AuthState {
  const factory AuthState({
    required bool isAuthenticated,
    required dynamic user,
    required bool isUserApp,
    required bool isSpeaker,
    required bool isAdmin,
    required bool isCommission,
    required bool isStudant,
    required Relationship relationship,
  }) = _AuthState;
}
