import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:setec_app/core/enums/social_media_enum.dart';
import 'package:setec_app/core/interface/user_wrapper_interface.dart';
import 'package:setec_app/model/models/user/user_app.dart';

part 'speaker.freezed.dart';
part 'speaker.g.dart';

@freezed
abstract class Speaker with _$Speaker implements UserWrapper {
  factory Speaker({
    int? id,
    required UserApp user,
    required String? company,
    required String position,
    required String bio,
    bool? isApproved,
    String? adminUid,
    required Map<SocialMedia, String>? socialMedia,
  }) = _Speaker;

  factory Speaker.fromJson(Map<String, Object?> json) =>
      _$SpeakerFromJson(json);
}
