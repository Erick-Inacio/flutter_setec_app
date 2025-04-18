import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:setec_app/core/classes/result_class.dart';
import 'package:setec_app/core/enums/relationship.dart';
import 'package:setec_app/core/mixins/shared_prefs_mixin.dart';
import 'package:setec_app/data/firebase/auth/firebase_email_repository.dart';
import 'package:setec_app/domain/models/auth_state.dart';
import 'package:setec_app/domain/models/speaker.dart';
import 'package:setec_app/domain/models/user_app.dart';

class AuthStateNotifier extends StateNotifier<AuthState> with SharedPrefsMixin {
  AuthStateNotifier()
      : super(const AuthState(
            isAuthenticated: false,
            user: null,
            isUserApp: false,
            isSpeaker: false,
            isAdmin: false,
            isCommission: false,
            isStudant: false,
            relationship: Relationship.semrelacao));

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

  Future<void> logout(dynamic user) async {
    final response = await FirebaseEmailReapository().logout();

    if (response is Error) throw response.error;

    if (user is UserApp) {
      final result = await mixinRemove('userApp') as Result;
      if (result is Error) throw result.error;
    } else if (user is Speaker) {
      final result = await mixinRemove('speaker') as Result;
      if (result is Error) throw result.error;
    }

    state = const AuthState(
        isAuthenticated: false,
        user: null,
        isUserApp: false,
        isSpeaker: false,
        isAdmin: false,
        isCommission: false,
        isStudant: false,
        relationship: Relationship.semrelacao);
  }
}

final authProvider = StateNotifierProvider<AuthStateNotifier, AuthState>(
  (ref) => AuthStateNotifier(),
);

// Provider para o GoRouter
final authListenableProvider = Provider<ValueNotifier<AuthState>>((ref) {
  final state = ref.watch(authProvider);
  return ValueNotifier(state);
});
