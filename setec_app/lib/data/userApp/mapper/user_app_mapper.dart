import 'package:setec_app/data/userApp/dto/user_app_dto.dart';
import 'package:setec_app/domain/models/user_app.dart';

extension UserAppDTOMapperToDomain on UserAppDTO {
  UserApp toDomain() {
    return UserApp(
      id: id,
      uid: uid,
      name: name,
      email: email,
      role: role,
      ra: ra,
      relationship: relationship,
    );
  }
}

extension UserAppMapperToDTO on UserApp {
  UserAppDTO toDTO() {
    return UserAppDTO(
      id: id,
      uid: uid,
      name: name,
      email: email,
      role: role,
      ra: ra,
      relationship: relationship,
    );
  }
}