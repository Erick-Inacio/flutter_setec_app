import 'package:json_annotation/json_annotation.dart';

@JsonEnum()
enum SocialMedia {
  @JsonValue("FACEBOOK")
  facebook("Facebook"),
  @JsonValue("LINKEDIN")
  linkedin("Linkedin"),
  @JsonValue("INSTAGRAM")
  instagram("Instagram"),
  @JsonValue("TWITTER")
  twitter("Twitter"),
  @JsonValue("WHATSAPP")
  whatsapp("WhatsApp"),
  @JsonValue("YOUTUBE")
  youtube("Youtube"),
  @JsonValue("TELEGRAM")
  telegram("Telegram"),
  @JsonValue("GITHUB")
  github("Github"),
  @JsonValue("TIKTOK")
  tiktok("Tiktok"),
  @JsonValue("WEBSITE")
  website("WebSite");

  final String displayName;
  const SocialMedia(this.displayName);
}
