import 'package:setec_app/data/activity/dto/activity_dto.dart';
import 'package:setec_app/data/typeActivity/mapping/type_activity_mapping.dart';
import 'package:setec_app/model/extensions/event_extension.dart';
import 'package:setec_app/model/models/activity/activity.dart';

extension ActivityMapperToDTO on Activity {
  ActivityDTO toDTO() {
    return ActivityDTO(
      id: id,
      name: name,
      typeActivity: typeActivity?.toDTO(),
      event: event?.toDTO(),
      daysQuantity: daysQuantity,
      hoursQuantity: hoursQuantity,
      qtdeVagas: qtdeVagas,
    );
  }
}

extension ActivityMapperToModel on ActivityDTO {
  Activity toModelo() {
    return Activity(
      id: id,
      name: name,
      typeActivity: typeActivity?.toModel(),
      event: event?.toModel(),
      daysQuantity: daysQuantity,
      hoursQuantity: hoursQuantity,
      qtdeVagas: qtdeVagas,
    );
  }
}
