import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:setec_app/core/base/base_repository.dart';
import 'package:setec_app/core/classes/result_class.dart';
import 'package:setec_app/core/interface/basic_repository_crud.dart';
import 'package:setec_app/data/event/dto/event_dto.dart';
import 'package:setec_app/data/event/service/event_services.dart';
import 'package:setec_app/model/extensions/event_extension.dart';
import 'package:setec_app/model/models/event.dart';

class EventRepository extends BaseRepository<EventDTO>
  implements BasicRepositoryCRUD<Event> {
  EventRepository()
      : super(
          storageKey: 'event',
          service: EventServices(),
        );

  @override
  Future<Result<List<Event>>> findAllDataPaged({int lastId = 1, int size = 10}) {
    return getAllPaged<Event, EventDTO>(lastId: lastId, size: size);
  }

  @override
  Future<Result<List<Event>>> findAllData() {
    return getAll<Event, EventDTO>();
  }

  @override
  Future<Result<Event>> findByDataId(int id) {
    return getById<Event, EventDTO>(id);
  }

  @override
  Future<Result<Event>> createData(Event event) {
    return create<Event, EventDTO>(
        domain: event, toDTO: (event) => event.toDTO());
  }

  @override
  Future<Result<Event>> updateData(Event event) {
    return update<Event, EventDTO>(
        domain: event, toDTO: (event) => event.toDTO());
  }

  @override
  Future<Result<void>> deleteData(int id) {
    return delete(id);
  }
  

  // Future<Result<List<Event>>> getEventsSemAuth() {
  //   return handleResult(() async {
  //     final result = await EventServices().getEventsWithNoAuth();

  //     switch (result) {
  //       case Ok(value: final events):
  //         return events.map((e) => e.toDomain()).toList();
  //       case Error(error: final e):
  //         throw e;
  //     }
  //   });
  // }
}

final eventRepoProvider = Provider<EventRepository>((ref) {
  return EventRepository(); // classe com métodos utilitários, sem estado
});
