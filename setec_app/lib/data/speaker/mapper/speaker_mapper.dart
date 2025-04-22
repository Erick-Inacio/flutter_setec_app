import 'package:setec_app/data/speaker/dto/speaker_dto.dart';
import 'package:setec_app/data/userApp/mapper/user_app_mapper.dart';
import 'package:setec_app/model/models/speaker.dart';

extension SpeakerToDomain on SpeakerDTO {
  Speaker toDomain() {
    return Speaker(
      id: id,
      socialMedia: socialMedia,
      company: company,
      position: position,
      bio: bio,
      user: user.toDomain(),
      adminApproved: adminApproved,
      isApproved: adminApproved != null,
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
      adminApproved: adminApproved,
    );
  }
}