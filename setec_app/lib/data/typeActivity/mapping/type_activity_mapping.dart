import 'package:setec_app/data/typeActivity/dto/type_activity_dto.dart';
import 'package:setec_app/model/models/typeActivity/type_activity.dart';

extension TypeActivityMapperToDTO on TypeActivity {
  TypeActivityDTO toDTO() {
    return TypeActivityDTO(
      id: id,
      name: name,
      needsSubscription: needsSubscription,
    );
  }
}

extension TypeActivityMapperToDomain on TypeActivityDTO {
  TypeActivity toModelo() {
    return TypeActivity(
      id: id,
      name: name,
      needsSubscription: needsSubscription,
    );
  }
}
