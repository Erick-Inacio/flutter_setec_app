import 'package:setec_app/data/speaker/dto/speaker_dto.dart';
import 'package:setec_app/data/userApp/mapper/user_app_mapper.dart';
import 'package:setec_app/domain/models/speaker.dart';

extension SpeakerMapperToDTO on Speaker {
  SpeakerDTO toDTO() => SpeakerDTO(
        bio: bio,
        company: company,
        id: id,
        position: position,
        socialMedia: socialMedia,
        user: user.toDTO(),
      );
}
