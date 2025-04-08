import 'package:setec_app/data/core/base_routes.dart';

class SpeakerRoutes extends BaseRoutes {
  SpeakerRoutes() : super(controllerName: 'speaker');

  String getByUser(int userId) => custom(
        endpoint: 'getByUser',
        params: {'userId': userId.toString()},
      );
}
