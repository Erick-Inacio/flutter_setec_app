import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:setec_app/core/classes/result_class.dart';
import 'package:setec_app/core/enums/relationship.dart';
import 'package:setec_app/core/enums/roles.dart';
import 'package:setec_app/core/interface/user_wrapper_interface.dart';
import 'package:setec_app/core/mixins/shared_prefs_mixin.dart';
import 'package:setec_app/data/firebase/auth/firebase_email_repository.dart';
import 'package:setec_app/model/models/auth/auth_state.dart';
import 'package:setec_app/model/models/speaker/speaker.dart';
import 'package:setec_app/model/models/user/user_app.dart';

class AuthStateNotifier extends StateNotifier<AuthState> with SharedPrefsMixin {
  AuthStateNotifier() : super(AuthState.initial);

  void login({
    required UserWrapper user,
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

  Future<void> logout(Object user) async {
    final response = await FirebaseEmailRepository().logout();

    if (response is Error) throw response.error;

    if (user is UserApp) {
      final result = await mixinRemove('userApp') as Result;
      if (result is Error) throw result.error;
    } else if (user is Speaker) {
      final result = await mixinRemove('speaker') as Result;
      if (result is Error) throw result.error;
    }

    state = AuthState.initial;
  }

  void updateAuthState({required UserWrapper newUser}) async {
    state = AuthState(
      isAuthenticated: true,
      user: newUser,
      isUserApp: newUser is UserAppWrapper,
      isSpeaker: newUser is Speaker,
      isAdmin: newUser.user.role == Roles.admin,
      isCommission: newUser.user.role == Roles.commission,
      isStudant: newUser.user.role == Roles.student,
      relationship: newUser.user.relationship,
    );

    
    // final result = await mixinSaveObject(
    //   key: state.isSpeaker ? 'speaker' : 'userApp',
    //   object: newUser.user,
    // );

    // if (result is Error) throw AppException(result.error.toString());
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
