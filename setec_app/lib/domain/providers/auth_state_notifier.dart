import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:setec_app/core/enums/relationship.dart';
import 'package:setec_app/domain/models/auth_state.dart';

class AuthStateNotifiier extends StateNotifier<AuthState> {
  AuthStateNotifiier() : super(const AuthState(isAuthenticated: false));

  void login({
    dynamic user,
    required bool isUserApp,
    required bool isSpeaker,
    required bool isAdmin,
    required bool isCommission,
    required bool isStudant,
    required Relationship relationship,
  }) {
    state = state.copyWith(
      isAuthenticated: true,
      user: user,
      isUserApp: isUserApp,
      isSpeaker: isSpeaker,
      isAdmin: isAdmin,
      isCommission: isCommission,
      isStudant: isStudant,
      relationship: relationship,
    );
  }

  void logout() {
    state = const AuthState(isAuthenticated: false);
  }
}

final authProvider = StateNotifierProvider<AuthStateNotifiier, AuthState>(
  (ref) => AuthStateNotifiier(),
);
