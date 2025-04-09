import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:setec_app/core/classes/app_exception_class.dart';
import 'package:setec_app/core/classes/result_class.dart';
import 'package:setec_app/core/enums/roles.dart';
import 'package:setec_app/data/firebase/auth/auth_repository.dart';
import 'package:setec_app/data/speaker/service/speaker_services.dart';
import 'package:setec_app/domain/models/user_app.dart';
import 'package:setec_app/providers/session_provider.dart';

class AuthViewModel extends ChangeNotifier {
  AuthViewModel({
    required this.authRepository,
    
  });

  final AuthRepository authRepository;

  UserApp? _userApp;
  bool _isLoading = false;

  UserApp? get userApp => _userApp;
  bool get isLoading => _isLoading;

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  Future<Result<void>> navigationTo({
    required BuildContext context,
    required GlobalKey<FormState> formKey,
    required TextEditingController email,
    required TextEditingController password,
  }) async {
    return handleResult(() async {
      if (!formKey.currentState!.validate()) return;

      _setLoading(true);
      try {
        final result = await authRepository.login(email.text, password.text);

        switch (result) {
          case Ok(value: final user):
            _userApp = user;
            break;
          case Error(error: final e):
            throw e;
        }

        if (_userApp == null) throw Exception("Usuário inválido.");

        final session =
            context.mounted ? context.read<SessionProvider>() : null;
        session!.setUser(_userApp!);

        // Se for speaker, buscar dados do Speaker
        if (_userApp!.role == Roles.speaker) {
          final speakerResult =
              await SpeakerServices().getByUser(_userApp!.id!);

          switch (speakerResult) {
            case Ok(value: final speaker):
              session.setUser(speaker);
              context.mounted ? context.go('/lectures') : null;
              return;
            case Error(error: final e):
              session.clearSession();
              throw AppException("Erro ao buscar dados do palestrante: $e");
          }
        }

        // Se for outro tipo, redireciona normal
        context.mounted ? context.go('/lectures') : null;
      } catch (e) {
        context.mounted ? context.read<SessionProvider>().clearSession() : null;

        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Erro: ${e.toString()}")),
          );
        }

        Logger().e('LoginWithEmail: $e');
        rethrow;
      } finally {
        _setLoading(false);
      }
    });
  }
}
