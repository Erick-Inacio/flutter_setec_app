import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:setec_app/core/classes/app_exception_class.dart';
import 'package:setec_app/core/classes/result_class.dart';
import 'package:setec_app/core/enums/relationship.dart';
import 'package:setec_app/core/enums/roles.dart';
import 'package:setec_app/data/firebase/auth/auth_repository.dart';
import 'package:setec_app/data/speaker/service/speaker_services.dart';
import 'package:setec_app/domain/models/user_app.dart';
import 'package:setec_app/domain/providers/auth_state_notifier.dart';

class AuthAsyncNotifier extends AsyncNotifier<void> {
  late final AuthRepository authRepository;
  late final SpeakerServices speakerServices;

  @override
  Future<void> build() async {
    authRepository = AuthRepository();
    speakerServices = SpeakerServices();
  }

  Future<void> login({
    required GlobalKey<FormState> formKey,
    required TextEditingController email,
    required TextEditingController password,
    required BuildContext context,
  }) async {
    if (!formKey.currentState!.validate()) return;

    state = const AsyncLoading();

    try {
      final result = await authRepository.login(email.text, password.text);

      UserApp userApp;
      switch (result) {
        case Ok(value: final user):
          userApp = user;
        case Error(error: final e):
          throw e;
      }

      // Salvar no authProvider global
      ref.read(authProvider.notifier).login(
            user: userApp,
            isUserApp: userApp.role == Roles.student,
            isSpeaker: userApp.role == Roles.speaker,
            isAdmin: userApp.role == Roles.admin,
            isCommission: userApp.role == Roles.commission,
            isStudant: userApp.role == Roles.student,
            relationship: userApp.relationship,
          );

      // Se for speaker, carrega os dados adicionais
      if (userApp.role == Roles.speaker) {
        final speakerResult = await speakerServices.getByUser(userApp.id!);

        switch (speakerResult) {
          case Ok(value: final speaker):
            ref.read(authProvider.notifier).login(
                  user: speaker,
                  isUserApp: false,
                  isSpeaker: true,
                  isAdmin: false,
                  isCommission: false,
                  isStudant: false,
                  relationship: speaker.user.relationship,
                );
            break;

          case Error(error: final e):
            ref.read(authProvider.notifier).logout();
            throw AppException("Erro ao buscar dados do palestrante: $e");
        }
      }

      // Navegar
      if (context.mounted) context.go('/lectures');

      state = const AsyncData(null);
    } catch (e, s) {
      state = AsyncError(e, s);

      if (context.mounted) {
        ref.read(authProvider.notifier).logout();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Erro: ${e.toString()}")),
        );
      }
    }
  }

  Future<void> createAccount({
    required String name,
    required String email,
    required String password,
    required Relationship relationship,
    required BuildContext context,
  }) async {
    state = const AsyncLoading();

    try {
      // Exemplo mock — substitua com sua lógica real de criação:
      final createdUser = await authRepository.registerWithEmail(
        email
      );

      // Salva no estado global
      ref.read(authProvider.notifier).login(
            user: createdUser,
            isUserApp: true,
            isSpeaker: false,
            isAdmin: false,
            isCommission: false,
            isStudant: true,
            relationship: relationship,
          );

      if (context.mounted) {
        context.go('/criarUsuario'); // ou outra rota
      }

      state = const AsyncData(null);
    } catch (e, s) {
      state = AsyncError(e, s);
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Erro: ${e.toString()}")),
        );
      }
    }
  }
}

final authAsyncProvider =
    AsyncNotifierProvider<AuthAsyncNotifier, void>(() => AuthAsyncNotifier());
