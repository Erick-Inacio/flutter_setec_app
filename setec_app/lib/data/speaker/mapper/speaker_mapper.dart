import 'package:setec_app/data/speaker/dto/speaker_dto.dart';
import 'package:setec_app/domain/models/speaker.dart';

extension SpeakerToDomain on SpeakerDTO {
  Speaker toDomain() {
    return Speaker(
      id: id,
      socialMedia: socialMedia,
      company: company,
      position: position,
      bio: bio,
      user: user!.toDomain(),
    );
  }
}

extension SpeakerToDTO on Speaker {
  SpeakerDTO toDTO() {
    return SpeakerDTO(
      id: id,
      socialMedia: socialMedia,
      company: company,
      position: position,
      bio: bio,
      user: user.toDTO(),
    );
  }
}