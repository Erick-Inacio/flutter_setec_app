import 'dart:async';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:setec_app/core/classes/app_exception_class.dart';
import 'package:setec_app/core/classes/result_class.dart';
import 'package:setec_app/core/interface/user_wrapper_interface.dart';
import 'package:setec_app/data/speaker/repository/speaker_repository.dart';
import 'package:setec_app/model/models/speaker/speaker.dart';

final speakerViewModel = AsyncNotifierProvider<SpeakerViewModel, List<Speaker>>(
  () => SpeakerViewModel(),
);

class SpeakerViewModel extends AsyncNotifier<List<Speaker>> {
  late final SpeakerRepository _repository;

  @override
  Future<List<Speaker>> build() async{
    _repository = ref.read(speakerRepository);
    return await fetchSpeaker();
  }

  Future<List<Speaker>> fetchSpeaker() async {
    state = await AsyncValue.guard(() async {
      final result = await _repository.findAllData();

      return switch (result) {
        Ok(value: final value) => value,
        Error(error: final e) => throw e,
      };
    });
    return state.value ?? [];
  }

  Future<void> updateProfile({required UserWrapper user}) async {
    state = await AsyncValue.guard(() async {
      if (user is! Speaker) {
        throw AppException(
          'Tipo de usuário não reconhecido',
        );
      }

      final result = await _repository.updateData(user);

      final updatedUser = switch (result) {
        Ok(value: final value) => value,
        Error(error: final e) => throw e,
      };

      final current = state.valueOrNull ?? [];

      return [
        for (final s in current)
          if (s.id == updatedUser.id) updatedUser else s
      ];
    });
  }
}
