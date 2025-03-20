import 'package:setec_app/models/user_app_model.dart';
import 'package:setec_app/providers/base_provider.dart';
import 'package:setec_app/services/backend/user_services.dart';

class UserAppProvider extends BaseProvider<UserApp> {
  UserAppProvider()
      : super(
          field: 'user',
          service: UserServices(),
          fromJson: UserApp.fromJson,
          toJson: (userApp) => userApp.toJson(),
        );
}
