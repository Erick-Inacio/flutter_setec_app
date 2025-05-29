import 'package:json_annotation/json_annotation.dart';
import 'package:setec_app/core/classes/mappable_class.dart';
import 'package:setec_app/data/activity/mapping/activity_mapping.dart';
import 'package:setec_app/data/event/dto/event_dto.dart';
import 'package:setec_app/data/typeActivity/dto/type_activity_dto.dart';
import 'package:setec_app/model/models/activity/activity.dart';

part 'activity_dto.g.dart';

@JsonSerializable()
class ActivityDTO implements DTOConvertible<Activity>{
  
  int? id;
    String? name;
    TypeActivityDTO? typeActivity;
    EventDTO? event;
    int? daysQuantity;
    int? hoursQuantity;
    int? qtdeVagas;
  
  ActivityDTO({
    this.id,
    this.name,
    this.typeActivity,
    this.event,
    this.daysQuantity,
    this.hoursQuantity,
    this.qtdeVagas
  });

  @override
  Activity toModel() => toModelo();

  factory ActivityDTO.fromJson(Map<String, dynamic> json) =>
      _$ActivityDTOFromJson(json);
  Map<String, dynamic> toJson() => _$ActivityDTOToJson(this);
}