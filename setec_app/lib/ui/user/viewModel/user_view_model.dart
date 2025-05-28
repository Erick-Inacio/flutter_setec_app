import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:setec_app/core/classes/app_exception_class.dart';
import 'package:setec_app/core/classes/result_class.dart';
import 'package:setec_app/core/interface/user_wrapper_interface.dart';
import 'package:setec_app/data/speaker/repository/speaker_repository.dart';
import 'package:setec_app/data/userApp/repository/user_app_repository.dart';
import 'package:setec_app/model/models/speaker/speaker.dart';
import 'package:setec_app/providers/auth_state_notifier.dart';

final userViewModel = AsyncNotifierProvider<UserViewModel, UserWrapper>(
  () => UserViewModel(),
);

class UserViewModel extends AsyncNotifier<UserWrapper> {
  late final SpeakerRepository _speakerRepo;
  late final UserAppRepository _userAppRepo;

  @override
  UserWrapper build() {
    _speakerRepo = ref.read(speakerRepository);
    _userAppRepo = ref.read(userAppRepository);

    return UserWrapper.wrap(ref.read(authProvider).user);
  }

  Future<void> updateProfile(
      {required UserWrapper user, bool isSelfUser = false}) async {
    state = const AsyncLoading();

    if (user is Speaker) {
      _handleResult<Speaker>(await _speakerRepo.updateData(user));
    } else if (user is UserAppWrapper) {
      _handleResult((await _userAppRepo.updateData(user.user)).map(
        (u) => UserAppWrapper(u),
      ));
    } else {
      state = AsyncError(
        AppException('Tipo de usuário não reconhecido'),
        StackTrace.current,
      );
      return;
    }

    if (isSelfUser) {
        ref.read(authProvider.notifier).updateAuthState(newUser: user);
    }
  }

  void _handleResult<T extends UserWrapper>(Result<T> result) {
    switch (result) {
      case Ok(value: final value):
        state = AsyncValue.data(value);
        break;
      case Error(error: final e):
        state = AsyncValue.error(e, StackTrace.current);
        break;
    }
  }
}
