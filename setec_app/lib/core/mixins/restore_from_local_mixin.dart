import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:setec_app/core/classes/result_class.dart';
import 'package:setec_app/core/enums/roles.dart';
import 'package:setec_app/data/speaker/dto/speaker_dto.dart';
import 'package:setec_app/data/speaker/repository/speaker_repository.dart';
import 'package:setec_app/data/userApp/dto/user_app_dto.dart';
import 'package:setec_app/data/userApp/repository/user_app_repository.dart';
import 'package:setec_app/providers/auth_state_notifier.dart';
import 'package:setec_app/providers/event_provider.dart';

mixin RestoreDataFromLocal {
  Future<void> restoreFromLocal(WidgetRef ref) async {
    await Future.wait([
      _restoreFromLocal(ref),
      _restoreEvent(ref),
    ]);
  }

  Future<void> _restoreFromLocal(WidgetRef ref) async {
    final userAppRep = ref.read(userAppRepository);
    final speakerRep = ref.read(speakerRepository);

    final result = await userAppRep.getObjectLocal();

    switch (result) {
      case Ok(value: final value):
        if (value == null) return;

        final roleStr = value['role'] as String;

        final role = Roles.fromString(roleStr);

        if (role == Roles.speaker) {
          final resultSpeaker = await speakerRep.getObjectLocal();

          final speaker = switch (resultSpeaker) {
            Ok(value: final v) =>
              v != null ? SpeakerDTO.fromJson(v).toDomain() : null,
            Error(error: final e) => throw e,
          };

          if (speaker != null) _login(ref, speaker, role);
        } else {
          final user = UserAppDTO.fromJson(value).toDomain();
          _login(ref, user, role);
        }
      case Error(error: final e):
        throw e;
    }
  }

  void _login(WidgetRef ref, var user, Roles role) {
    ref.read(authProvider.notifier).login(
          user: user,
          isAdmin: role == Roles.admin,
          isCommission: role == Roles.commission,
          isSpeaker: role == Roles.speaker,
          isUserApp: role == Roles.student,
          isStudant: role == Roles.student,
          relationship: role == Roles.speaker
              ? user.user.relationship
              : user.relationship,
        );
  }

  Future<void> _restoreEvent(WidgetRef ref) async {
    final result = await ref.read(eventNotifier.notifier).restoreFromLocal();

    switch (result) {
      case Ok(value: final value):
        if (value.isNotEmpty) return;

        final getEvents = await ref.read(eventNotifier.notifier).fetchEvents();

        if(getEvents is Error) throw getEvents.error;
      case Error(error: final e):
        throw e;
    }
  }
}
