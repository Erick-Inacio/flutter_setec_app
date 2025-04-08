import 'package:setec_app/core/base/base_provider.dart';
import 'package:setec_app/data/speaker/dto/speaker_dto.dart';
import 'package:setec_app/data/speaker/service/speaker_services.dart';

class SpeakerProvider extends BaseProvider<SpeakerDTO> {
  SpeakerProvider()
      : super(
          service: SpeakerServices(),
          field: "speaker",
          fromJson: SpeakerDTO.fromJson,
          toJson: (speaker) => speaker.toJson(),
        );
}
