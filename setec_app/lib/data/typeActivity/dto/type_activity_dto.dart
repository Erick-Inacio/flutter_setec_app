import 'package:json_annotation/json_annotation.dart';
import 'package:setec_app/core/classes/mappable_class.dart';
import 'package:setec_app/model/models/typeActivity/type_activity.dart';

part 'type_activity_dto.g.dart';

@JsonSerializable()
class TypeActivityDTO implements DTOConvertible<TypeActivity>{
  
  int? id;
  String? name;
  bool? needsSubscription;
  
  TypeActivityDTO({
    this.id,
    this.name,
    this.needsSubscription
  });

  @override
  TypeActivity toModel() => TypeActivity(
    id: id,
    name: name,
    needsSubscription: needsSubscription
  );

  factory TypeActivityDTO.fromJson(Map<String, dynamic> json) =>
      _$TypeActivityDTOFromJson(json);
  Map<String, dynamic> toJson() => _$TypeActivityDTOToJson(this);
}