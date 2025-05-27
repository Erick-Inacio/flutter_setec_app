import 'package:setec_app/data/core/base_routes.dart';

class EventRoutes extends BaseRoutes {
  EventRoutes() : super(controllerName: 'event');

  String getActivitiesByEventId(int eventId) => custom(
    endpoint: 'getActivitiesByEventId',
    params: {'eventId': eventId.toString()},
  );
}