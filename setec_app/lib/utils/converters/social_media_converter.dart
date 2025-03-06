import 'package:json_annotation/json_annotation.dart';
import 'package:setec_app/utils/enums/social_media_enum.dart';

class SocialMediaConverter
    implements JsonConverter<Map<SocialMedia, String>, dynamic> {
  const SocialMediaConverter();
  @override
  Map<SocialMedia, String> fromJson(dynamic json) {
    if (json is Map<String, dynamic>) {
      return json.map(
        (key, value) => MapEntry(_fromJsonKey(key), value as String),
      );
    }
    return {};
  }

  @override
  Map<String, String> toJson(Map<SocialMedia, String> socialMedia) {
    return socialMedia.map((key, value) => MapEntry(key.name, value));
  }

  static SocialMedia _fromJsonKey(String key) {
    return SocialMedia.values.firstWhere(
      (e) => e.name.toUpperCase() == key.toUpperCase(),
      orElse: () => SocialMedia.website,
    );
  }
}
