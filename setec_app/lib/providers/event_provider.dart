import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:setec_app/core/classes/result_class.dart';
import 'package:setec_app/core/mixins/shared_prefs_mixin.dart';
import 'package:setec_app/data/event/repository/event_repository.dart';
import 'package:setec_app/domain/models/event.dart';

class EventNotifier extends Notifier<List<Event>> with SharedPrefsMixin {
  late final EventRepository _repository;

  @override
  List<Event> build() {
    _repository = ref.read(eventRepoProvider);
    return [];
  }

  Future<Result<void>> fetchEvents() async {
    return handleResult(() async {
      final result = await _repository.getEventsSemAuth();

      switch (result) {
        case Ok(value: final events):
          state = events;
          final saveResult = await mixinSaveList(
            key: 'events',
            list: events,
          );
          if (saveResult is Error) throw saveResult.error;
          break;
        case Error(error: final e):
          throw e;
      }
    });
  }

  Future<Result<Event>> addEvent(Event event) async {
    return handleResult(() async {
      final result = await _repository.criarEvent(event);
      switch (result) {
        case Ok(value: final createdEvent):
          state = [...state, createdEvent];
          final saveResult = await mixinAddToList(
            key: 'events',
            newItem: createdEvent.toJson(),   
          );
          if (saveResult is Error) throw saveResult.error;
          return createdEvent;
        case Error(error: final e):
          throw e;
      }
    });
  }

  Future<Result<void>> deleteEvent(int id) async {
    return handleResult(() async {
      final result = await _repository.deletarEvent(id);
      switch (result) {
        case Ok():
          state = state.where((e) => e.id != id).toList();
          final deleteResult =
              await mixinRemoveFromListById(key: 'events', id: id);
          if (deleteResult is Error) throw deleteResult.error;
          break;
        case Error(error: final e):
          throw e;
      }
    });
  }

  Future<Result<Event>> updateEvent(Event event) async {
    return handleResult(() async {
      final result = await _repository.atualizarEvent(event);
      switch (result) {
        case Ok(value: final updated):
          state = state.map((e) => e.id == updated.id ? updated : e).toList();
          return updated;
        case Error(error: final e):
          throw e;
      }
    });
  }

  Future<Result<List<Event>>> restoreFromLocal() async {
    return handleResult(() async {
      final savedEvents = await mixinGetList('events');
      switch (savedEvents) {
        case Ok(value: final events):
          final list = events?.map((e) => Event.fromJson(e)).toList() ?? [];
          state = list;
          return list;
        case Error(error: final e):
          throw e;
      }
    });
  }
}

final eventNotifier =
    NotifierProvider<EventNotifier, List<Event>>(EventNotifier.new);
