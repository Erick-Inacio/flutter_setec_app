import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:setec_app/core/enums/relationship.dart';
import 'package:setec_app/core/enums/roles.dart';

part 'user_app.freezed.dart';
part 'user_app.g.dart';

@freezed
abstract class UserApp with _$UserApp {
  const factory UserApp({
    int? id,
    required String uid,
    required String name,
    required String email,
    required String? ra,
    required Roles role,
    required Relationship relationship,
  }) = _UserApp;
  
  factory UserApp.fromJson(Map<String, dynamic> json) =>
      _$UserAppFromJson(json);
}
