import 'package:json_annotation/json_annotation.dart';

part 'event_model.g.dart';

@JsonSerializable()
class Event {
  int? id;
  late DateTime initialDateTime;
  late DateTime finalDateTime;
  late String description;

  Event.empty();

  Event({
    this.id,
    required this.initialDateTime,
    required this.finalDateTime,
    required this.description,
  });

  factory Event.fromJson(Map<String, dynamic> json) => _$EventFromJson(json);
  Map<String, dynamic> toJson() => _$EventToJson(this);

  @override
  String toString() => 'Event{id: $id, initialDateTime: $initialDateTime, '
      'finalDateTime: $finalDateTime, description: $description}';
}
