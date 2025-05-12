import 'package:json_annotation/json_annotation.dart';
import 'package:setec_app/core/classes/mappable_class.dart';
import 'package:setec_app/model/models/event.dart';

part 'event_dto.g.dart';

@JsonSerializable()
class EventDTO implements DTOConvertible<Event> {
  int? id;
  late DateTime initialDateTime;
  late DateTime finalDateTime;
  late String name;

  EventDTO.empty();

  EventDTO({
    this.id,
    required this.initialDateTime,
    required this.finalDateTime,
    required this.name,
  });

  factory EventDTO.fromJson(Map<String, dynamic> json) =>
      _$EventDTOFromJson(json);
  Map<String, dynamic> toJson() => _$EventDTOToJson(this);

  @override
  Event toDomain() {
    return Event(
      id: id,
      initialDateTime: initialDateTime,
      finalDateTime: finalDateTime,
      name: name,
    );
  }

  @override
  String toString() => 'Event{id: $id, initialDateTime: $initialDateTime, '
      'finalDateTime: $finalDateTime, description: $name}';
}
