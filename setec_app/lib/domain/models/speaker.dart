import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:setec_app/core/enums/social_media_enum.dart';

part 'speaker.freezed.dart';

@freezed
abstract class Speaker with _$Speaker {
  const factory Speaker({
    int? id,
    required String company,
    required String position,
    required String bio,
    required dynamic user,
    required Map<SocialMedia, String> socialMedia,
  }) = _Speaker;
}
