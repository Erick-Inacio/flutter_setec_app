import 'package:setec_app/core/base/base_service.dart';
import 'package:setec_app/data/typeActivity/dto/type_activity_dto.dart';
import 'package:setec_app/data/typeActivity/routes/type_activity_routes.dart';

class TypeActivityService extends BaseService<TypeActivityDTO> {
  TypeActivityService() : super(
    apiRoute: TypeActivityRoutes(),
    fromJson: TypeActivityDTO.fromJson,
    toJson: (typeActivity) => typeActivity.toJson(),
  );
}
