import 'package:setec_app/data/speaker/dto/speaker_dto.dart';
import 'package:setec_app/data/userApp/mapper/user_app_mapper.dart';
import 'package:setec_app/model/models/speaker.dart';

extension SpeakerMapperToDTO on Speaker {
  SpeakerDTO toDTO() => SpeakerDTO(
        bio: bio,
        company: company,
        id: id,
        position: position,
        socialMedia: socialMedia,
        adminApproved: adminApproved,
        user: user.toDTO(),
      );
}
