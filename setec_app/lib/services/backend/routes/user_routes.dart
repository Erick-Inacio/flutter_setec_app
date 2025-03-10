import 'package:setec_app/services/backend/routes/base_routes.dart';

class UserRoutes extends BaseRoutes {
  UserRoutes() : super(controllerName: 'user');

  String getByUid(String uid) => custom(
        endpoint: 'getByUid',
        params: {'uid': uid},
      );
}
