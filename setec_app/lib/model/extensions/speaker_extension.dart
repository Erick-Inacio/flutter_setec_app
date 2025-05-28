import 'package:setec_app/data/speaker/dto/speaker_dto.dart';
import 'package:setec_app/data/userApp/mapper/user_app_mapper.dart';
import 'package:setec_app/model/models/speaker/speaker.dart';
import 'package:logger/logger.dart';

final logger = Logger(printer: PrettyPrinter()); // <- logger fixo

extension SpeakerMapperToDTO on Speaker {
  SpeakerDTO toDTO() {
    logger.d('[SpeakerMapperToDTO] Chamado');
    logger.d('🔍 isApproved: $isApproved');

    final speaker = SpeakerDTO(
      bio: bio,
      company: company,
      id: id,
      position: position,
      socialMedia: socialMedia,
      adminUid: adminUid,
      user: user.toDTO(),
      isApproved: isApproved,
    );

    logger.d('✅ SpeakerDTO criado: $speaker');
    return speaker;
  }
}
