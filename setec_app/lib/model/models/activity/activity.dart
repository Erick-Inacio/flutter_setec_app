import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:setec_app/model/models/event/event.dart';
import 'package:setec_app/model/models/typeActivity/type_activity.dart';

part 'activity.freezed.dart';
part 'activity.g.dart';

@freezed
abstract class Activity with _$Activity {
  factory Activity({
    int? id,
    String? name,
    TypeActivity? typeActivity,
    Event? event,
    int? daysQuantity,
    int? hoursQuantity,
    int? qtdeVagas,
  }) = _Activity;

  factory Activity.fromJson(Map<String, Object?> json) =>
      _$ActivityFromJson(json);
}
