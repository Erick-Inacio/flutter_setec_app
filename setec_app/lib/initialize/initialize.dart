// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:setec_app/core/classes/result_class.dart';
// import 'package:setec_app/core/enums/roles.dart';
// import 'package:setec_app/data/speaker/dto/speaker_dto.dart';
// import 'package:setec_app/data/speaker/repository/speaker_repository.dart';
// import 'package:setec_app/data/userApp/dto/user_app_dto.dart';
// import 'package:setec_app/data/userApp/repository/user_app_repository.dart';
// import 'package:setec_app/domain/models/user_app.dart';
// import 'package:setec_app/providers/auth_state_notifier.dart';

// class Initialize {
//   Initialize({
//     required this.ref,
//     required UserAppRepository userAppRepository,
//     required SpeakerRepository speakerRepository,
//   })  : _userAppRepository = userAppRepository,
//         _speakerRepository = speakerRepository;

//   final Ref ref;
//   final UserAppRepository _userAppRepository;
//   final SpeakerRepository _speakerRepository;

//   Future<Result<void>> initialize() {
//     return handleResult(() async {
//       final authState = ref.read(authProvider);

//       if (!authState.isAuthenticated) return;

//       final resultUser = await _userAppRepository.getObjectLocal();

//       switch (resultUser) {
//         case Ok(value: final value):
//           if (value != null) {
//             final userDTO = UserAppDTO.fromJson(value);
//             final user = userDTO.toDomain();
//             _login(user, user);
//           }
//         case Error(error: final e):
//           throw e;
//       }

//       final resultSpeaker = await _speakerRepository.getObjectLocal();

//       switch (resultSpeaker) {
//         case Ok(value: final value):
//           if (value != null) {
//             final speakerDTO = SpeakerDTO.fromJson(value);
//             final speaker = speakerDTO.toDomain();
//             final user = speaker.user;
//             _login(user, speaker);
//           }
//         case Error(error: final e):
//           throw e;
//       }
//     });
//   }

//   void _login(UserApp user, dynamic userType) {
//     ref.read(authProvider.notifier).login(
//           user: userType,
//           isAdmin: user.role == Roles.admin,
//           isCommission: user.role == Roles.commission,
//           isSpeaker: user.role == Roles.speaker,
//           isUserApp: user.role == Roles.student,
//           isStudant: user.role == Roles.student,
//           relationship: user.relationship,
//         );
//   }
// }
