import 'package:freezed_annotation/freezed_annotation.dart';

part 'type_activity.freezed.dart';
part 'type_activity.g.dart';

@freezed
abstract class TypeActivity with _$TypeActivity {
  factory TypeActivity({
    int? id,
    String? name,
    bool? needsSubscription
  }) = _TypeActivity;

  factory TypeActivity.fromJson(Map<String, Object?> json) =>
      _$TypeActivityFromJson(json);
}
