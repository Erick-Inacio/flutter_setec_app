import 'dart:async';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:setec_app/core/classes/result_class.dart';
import 'package:setec_app/data/speaker/repository/speaker_repository.dart';
import 'package:setec_app/model/models/speaker.dart';

final speakerViewModel = AsyncNotifierProvider<SpeakerViewModel, List<Speaker>>(
  () => SpeakerViewModel(),
);

class SpeakerViewModel extends AsyncNotifier<List<Speaker>> {
  late final SpeakerRepository _repository;

  @override
  List<Speaker> build() {
    _repository = ref.read(speakerRepository);
    fetchSpeaker();
    return [];
  }

  Future<void> fetchSpeaker() async {
    state = const AsyncLoading();
    final result = await _repository.findAllData();

    switch (result) {
      case Ok(value: final speakers):
        state = AsyncData(speakers);
        break;
      case Error(error: final e):
        state = AsyncError(e, StackTrace.current);
        break;
    }
  }

  Future<void> approveSpeaker(Speaker speaker, String adminUid) async {
    state = const AsyncLoading();

    final result = await _repository.approveSpeaker(
      speaker.copyWith(adminApproved: adminUid),
    );

    if (result is Error) {
      state = AsyncError(result.error, StackTrace.current);
      return;
    }

    await fetchSpeaker();
  }
}
