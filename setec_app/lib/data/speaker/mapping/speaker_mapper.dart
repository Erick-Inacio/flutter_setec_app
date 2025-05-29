import 'package:setec_app/data/speaker/dto/speaker_dto.dart';
import 'package:setec_app/data/userApp/mapper/user_app_mapper.dart';
import 'package:setec_app/model/models/speaker/speaker.dart';

extension SpeakerToDomain on SpeakerDTO {
  Speaker toModel() {
    return Speaker(
      id: id,
      socialMedia: socialMedia,
      company: company,
      position: position,
      bio: bio,
      user: user.toModel(),
      adminUid: adminUid,
      isApproved: adminUid != null,
    );
  }
}

extension SpeakerToDTO on Speaker {
  SpeakerDTO toDTO() {
    return SpeakerDTO(
      bio: bio,
      company: company,
      id: id,
      position: position,
      socialMedia: socialMedia,
      adminUid: adminUid,
      user: user.toDTO(),
      isApproved: isApproved,
    );
  }
}