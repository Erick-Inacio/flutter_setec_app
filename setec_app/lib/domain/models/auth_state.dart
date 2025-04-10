import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:setec_app/core/enums/relationship.dart';

part 'auth_state.freezed.dart';

@freezed
abstract class AuthState with _$AuthState {
  const factory AuthState({
    required bool isAuthenticated,
    dynamic user,
    bool? isUserApp,
    bool? isSpeaker,
    bool? isAdmin,
    bool? isCommission,
    bool? isStudant,
    Relationship? relationship,
  }) = _AuthState;
}
