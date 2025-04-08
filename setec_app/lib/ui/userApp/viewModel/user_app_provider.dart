import 'package:setec_app/data/userApp/dto/user_app_dto.dart';
import 'package:setec_app/data/userApp/service/user_services.dart';
import 'package:setec_app/core/base/base_provider.dart';

class UserAppProvider extends BaseProvider<UserAppDTO> {
  UserAppProvider()
      : super(
          field: 'user',
          service: UserServices(),
          fromJson: UserAppDTO.fromJson,
          toJson: (userApp) => userApp.toJson(),
        );
}
