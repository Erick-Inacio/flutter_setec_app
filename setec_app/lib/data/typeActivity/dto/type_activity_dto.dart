import 'package:json_annotation/json_annotation.dart';
import 'package:setec_app/core/classes/mappable_class.dart';
import 'package:setec_app/model/models/typeActivity/type_activity.dart';
import 'package:setec_app/data/typeActivity/mapping/type_activity_mapping.dart';

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
  TypeActivity toModel() => toModelo();

  factory TypeActivityDTO.fromJson(Map<String, dynamic> json) =>
      _$TypeActivityDTOFromJson(json);
  Map<String, dynamic> toJson() => _$TypeActivityDTOToJson(this);
}