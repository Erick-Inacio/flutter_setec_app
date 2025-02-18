import 'package:collection/collection.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonEnum(alwaysCreate: true)
enum SocialMedia {
  facebook("Facebook"),
  linkedin('Linkedin'),
  instagram('Instagram'),
  twitter('Twitter'),
  whatsapp('WhatsApp'),
  youtube('Youtube'),
  telegram('Telegram'),
  github('Github'),
  tiktok('Tiktok'),
  website('WebSite');

  final String displayName;
  const SocialMedia(this.displayName);

  static List<String> socialMediaName =
      SocialMedia.values.map((role) => role.displayName).toList();

  static SocialMedia? fromString(String role) {
    return SocialMedia.values.firstWhereOrNull(
      (e) => e.name.toLowerCase() == role.toLowerCase(),
    );
  }

  static SocialMedia? fromNameEnum(String name) {
    return SocialMedia.values.firstWhereOrNull(
      (e) => e.displayName.toLowerCase() == name.toLowerCase(),
    );
  }
}
