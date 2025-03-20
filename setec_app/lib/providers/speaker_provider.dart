import 'package:setec_app/models/speaker_model.dart';
import 'package:setec_app/providers/base_provider.dart';
import 'package:setec_app/services/backend/speaker_services.dart';

class SpeakerProvider extends BaseProvider<Speaker> {
  SpeakerProvider()
      : super(
          service: SpeakerServices(),
          field: "speaker",
          fromJson: Speaker.fromJson,
          toJson: (speaker) => speaker.toJson(),
        );
}
