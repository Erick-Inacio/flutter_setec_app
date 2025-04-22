import 'package:setec_app/data/event/dto/event_dto.dart';
import 'package:setec_app/model/models/event.dart';

extension  EventExtension on Event {
  EventDTO toDTO() {
    return EventDTO(
      id: id,
      initialDateTime: initialDateTime,
      finalDateTime: finalDateTime,
      description: description,
    );
  }
}