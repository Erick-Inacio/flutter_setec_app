import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:setec_app/core/classes/result_class.dart';
import 'package:setec_app/core/mixins/validate_form_fields.dart';
import 'package:setec_app/domain/models/event.dart';
import 'package:setec_app/providers/event_provider.dart';

final eventViewModel = AsyncNotifierProvider<EventViewModel, void>(() {
  return EventViewModel();
});

class EventViewModel extends AsyncNotifier<void> with ValidateFormFields {
  // late final EventRepository _eventRepository;
  @override
  FutureOr<void> build() {
    // _eventRepository = ref.read(eventRepoProvider);
    // return null;
  }

  Future<void> createEvent(BuildContext context, Event event) async {
    state = const AsyncLoading();
    final result = await ref.read(eventNotifier.notifier).addEvent(event);

    switch (result) {
      case Ok():
        state = const AsyncData(null);
          context.mounted ? context.pop() : null;
        break;
      case Error(error: final e):
        state = AsyncError(e, StackTrace.current);
        break;
    }
  }
}
