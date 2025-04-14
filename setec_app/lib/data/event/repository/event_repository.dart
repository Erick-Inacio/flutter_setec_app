import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:setec_app/core/base/base_repository.dart';
import 'package:setec_app/core/classes/result_class.dart';
import 'package:setec_app/data/event/dto/event_dto.dart';
import 'package:setec_app/data/event/service/event_services.dart';
import 'package:setec_app/domain/extensions/event_extension.dart';
import 'package:setec_app/domain/models/event.dart';

class EventRepository extends BaseRepository<EventDTO> {
  EventRepository()
      : super(
          storageKey: 'event',
          service: EventServices(),
        );

  Future<Result<List<Event>>> getTodosEvents() {
    return getAll<Event, EventDTO>();
  }

  Future<Result<Event>> buscarEventsPorId(int id) {
    return getById<Event, EventDTO>(id);
  }

  Future<Result<Event>> criarEvent(Event event) {
    return create<Event, EventDTO>(
        domain: event, toDTO: (event) => event.toDTO());
  }

  Future<Result<Event>> atualizarEvent(Event event) {
    return update<Event, EventDTO>(
        domain: event, toDTO: (event) => event.toDTO());
  }

  Future<Result<void>> deletarEvent(int id) {
    return delete(id);
  }

  Future<Result<List<Event>>> getEventsSemAuth() {
    return handleResult(() async {
      final result = await EventServices().getEventsWithNoAuth();

      switch (result) {
        case Ok(value: final events):
          return events.map((e) => e.toDomain()).toList();
        case Error(error: final e):
          throw e;
      }
    });
  }
}

final eventRepoProvider = Provider<EventRepository>((ref) {
  return EventRepository(); // classe com métodos utilitários, sem estado
});
