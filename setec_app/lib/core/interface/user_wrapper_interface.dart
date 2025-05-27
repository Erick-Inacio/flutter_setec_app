import 'package:setec_app/core/classes/app_exception_class.dart';
import 'package:setec_app/model/models/speaker/speaker.dart';
import 'package:setec_app/model/models/user/user_app.dart';

abstract class UserWrapper {
  UserApp get user;

  static UserWrapper wrap(Object? raw) {
    if (raw is UserApp) return UserAppWrapper(raw);
    if (raw is UserAppWrapper) return raw;
    if (raw is Speaker) return raw;
    throw AppException('Tipo de usuário não reconhecido');
  }
}

class UserAppWrapper implements UserWrapper {
  @override
  final UserApp user;

  UserAppWrapper(this.user);
}
