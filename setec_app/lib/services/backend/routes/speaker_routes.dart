import 'package:setec_app/services/backend/routes/base_routes.dart';

class SpeakerRoutes extends BaseRoutes {
  SpeakerRoutes() : super(controllerName: 'speaker');

  String getByUser(int userId) =>
      baseUrlWithParams('getByUser', {'userId': userId.toString()});
}
