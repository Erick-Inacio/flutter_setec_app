import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:setec_app/core/enums/social_media_enum.dart';
import 'package:setec_app/domain/models/user_app.dart';

part 'speaker.freezed.dart';
part 'speaker.g.dart';

@freezed
abstract class Speaker with _$Speaker {
  const factory Speaker({
    int? id,
    required String? company,
    required String position,
    required String bio,
    required UserApp user,
    required Map<SocialMedia, String>? socialMedia,
  }) = _Speaker;

  factory Speaker.fromJson(Map<String, Object?> json) => _$SpeakerFromJson(json);
}
