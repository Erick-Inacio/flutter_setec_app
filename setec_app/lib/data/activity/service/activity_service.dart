import 'package:setec_app/core/base/base_service.dart';
import 'package:setec_app/data/activity/dto/activity_dto.dart';
import 'package:setec_app/data/activity/routes/activity_routes.dart';

class ActivityService extends BaseService<ActivityDTO> {
  ActivityService() : super(
    apiRoute: ActivityRoutes(),
    fromJson: ActivityDTO.fromJson,
    toJson: (typeActivity) => typeActivity.toJson(),
  );
}
