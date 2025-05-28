import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:logger/web.dart';
import 'package:setec_app/core/classes/app_exception_class.dart';
import 'package:setec_app/core/classes/result_class.dart';
import 'package:setec_app/core/enums/relationship.dart';
import 'package:setec_app/core/enums/roles.dart';
import 'package:setec_app/core/interface/user_wrapper_interface.dart';
import 'package:setec_app/core/mixins/enum_lists.dart';
import 'package:setec_app/core/mixins/validate_form_fields.dart';
import 'package:setec_app/data/firebase/auth/firebase_email_repository.dart';
import 'package:setec_app/data/speaker/mapping/speaker_mapper.dart';
import 'package:setec_app/data/speaker/repository/speaker_repository.dart';
import 'package:setec_app/data/userApp/mapper/user_app_mapper.dart';
import 'package:setec_app/data/userApp/repository/user_app_repository.dart';
import 'package:setec_app/model/models/speaker/speaker.dart';
import 'package:setec_app/model/models/user/user_app.dart';
import 'package:setec_app/providers/auth_state_notifier.dart';
import 'package:setec_app/ui/utils/widgets/snackBar/exception_snack_bar.dart';

final authAsyncProvider = AsyncNotifierProvider<AuthAsyncNotifier, void>(() {
  return AuthAsyncNotifier(
    authRepository: FirebaseEmailRepository(),
    speakerRepository: SpeakerRepository(),
    userAppRepository: UserAppRepository(),
  );
});

class AuthAsyncNotifier extends AsyncNotifier<void> with ValidateFormFields, EnumLists {
  AuthAsyncNotifier({
    required FirebaseEmailRepository authRepository,
    required SpeakerRepository speakerRepository,
    required UserAppRepository userAppRepository,
  })  : _authRepository = authRepository,
        _speakerRepository = speakerRepository,
        _userAppRepository = userAppRepository;

  late final FirebaseEmailRepository _authRepository;
  late final SpeakerRepository _speakerRepository;
  late final UserAppRepository _userAppRepository;

  @override
  Future<void> build() async {}

  Future<void> login({
    required GlobalKey<FormState> formKey,
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    if (!formKey.currentState!.validate()) return;
    state = const AsyncLoading();
    final authState = ref.read(authProvider);

    try {
      final result = await _authRepository.login(email, password);

      UserApp userApp;
      switch (result) {
        case Ok(value: final user):
          userApp = user;
          _setLogin(
            user: UserAppWrapper(userApp),
            isUserApp: userApp.role != Roles.speaker,
            isSpeaker: userApp.role == Roles.speaker,
            isAdmin: userApp.role == Roles.admin,
            isCommission: userApp.role == Roles.commission,
            isStudant: userApp.role == Roles.student,
            relationship: userApp.relationship,
          );

          _userAppRepository.saveObjectLocal(userApp.toDTO());
          break;
        case Error(error: final e):
          throw e;
      }

      if (userApp.role == Roles.speaker) {
        final speakerResult =
            await _speakerRepository.getByUserApp(userApp.id!);

        switch (speakerResult) {
          case Ok(value: final speaker):
            _setLogin(
              user: speaker,
              isSpeaker: true,
              relationship: speaker.user.relationship,
            );

            _speakerRepository.saveObjectLocal(speaker.toDTO());
            break;
          case Error(error: final e):
            ref.read(authProvider.notifier).logout(authState.user!);
            throw AppException("Erro ao buscar dados do palestrante: $e");
        }
      }

      if (context.mounted) context.go('/lectures');

      // Navigator.of(context, rootNavigator: true).pushNamedAndRemoveUntil(
      //   '/lectures',
      //   (route) => false,
      // );

      state = const AsyncData(null);
    } catch (e, s) {
      state = AsyncError(e, s);

      if (context.mounted) {
        //FIXME: tratar o erro caso a api esteja offline
        // ref.read(authProvider.notifier).logout(authState.user!);
        Logger().e(s);
        ScaffoldMessenger.of(context).showSnackBar(
          ExceptionSnackBar(
            message: "Erro: ${e.toString()}",
          ),
        );
      }
    }
  }

  Future<void> createUser({
    required GlobalKey<FormState> formKey,
    required String email,
    required String password,
    required BuildContext context,
    required UserApp user,
    required bool isSpeaker,
    required String? bio,
    required String? company,
    required String? position,
  }) async {
    if (!formKey.currentState!.validate()) return;

    final userEntity = isSpeaker
        ? Speaker(
            company: company,
            position: position!,
            bio: bio!,
            user: user,
            socialMedia: null,
            isApproved: false
          )
        : user;

    await _createAccount(
        formKey: formKey,
        email: email,
        password: password,
        context: context,
        user: userEntity,
        isSpeaker: isSpeaker);
  }

  Future<void> _createAccount({
    required GlobalKey<FormState> formKey,
    required String email,
    required String password,
    required BuildContext context,
    required dynamic user, // Pode ser UserApp ou Speaker
    required bool isSpeaker,
  }) async {
    state = const AsyncLoading();

    try {
      final createdFirebaseUser = await _authRepository.registerWithEmail(
        email: email,
        password: password,
      );
      // Logger().i(user.toString());
      switch (createdFirebaseUser) {
        case Ok(value: final createdUser):
          String? ra;

          if (isSpeaker) {
            ra = user.user.ra == '' ? null : user.user.ra;
          } else {
            ra = user.ra == '' ? null : user.ra;
          }

          // Dados base
          final userApp = UserApp(
            uid: createdUser.uid,
            name: user is UserApp ? user.name : user.user.name,
            email: createdUser.email,
            role: user is UserApp ? user.role : user.user.role,
            ra: ra,
            relationship:
                user is UserApp ? user.relationship : user.user.relationship,
          );

          final result = await _userAppRepository.createData(userApp);

          switch (result) {
            case Ok(value: final savedUserApp):
              if (user is UserApp) {
                _setLogin(
                  user: UserAppWrapper(savedUserApp),
                  isUserApp: true,
                  isAdmin: savedUserApp.role == Roles.admin,
                  isCommission: savedUserApp.role == Roles.commission,
                  isStudant: savedUserApp.role == Roles.student,
                  relationship: savedUserApp.relationship,
                );
              } else if (user is Speaker) {
                final speaker = user.copyWith(user: savedUserApp);

                final result = await _speakerRepository.createData(speaker);

                switch (result) {
                  case Ok(value: final savedSpeaker):
                    _setLogin(
                      user: savedSpeaker,
                      isSpeaker: true,
                      relationship: savedSpeaker.user.relationship,
                    );
                    break;
                  case Error(error: final e):
                    throw e;
                }
              }
              break;
            case Error(error: final e):
              throw e;
          }
          break; //testeaccount@teste.com

        case Error(error: final e):
          throw e;
      }

      if (context.mounted) context.go('/lectures');
      state = const AsyncData(null);
    } catch (e, s) {
      state = AsyncError(e, s);
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          ExceptionSnackBar(message: "Erro: ${e.toString()}"),
        );
      }
    }
  }

  void _setLogin({
    required UserWrapper user,
    required Relationship relationship,
    bool isUserApp = false,
    bool isSpeaker = false,
    bool isAdmin = false,
    bool isCommission = false,
    bool isStudant = false,
  }) {
    ref.read(authProvider.notifier).login(
          user: user,
          isUserApp: isUserApp,
          isSpeaker: isSpeaker,
          isAdmin: isAdmin,
          isCommission: isCommission,
          isStudant: isStudant,
          relationship: relationship,
        );
  }

  String? validatePassword(String? value) {
    Logger().i('entrou');
    return isValidPassword(value);
  }

  String? validateEmail(String? value) {
    return isValidEmail(value);
  }

  String? validateName(String? value) {
    return isValidName(value);
  }

  List<DropdownMenuItem> relationShipItems() {
    return listRelationship();
  }
}
