import 'package:setec_app/core/base/base_repository.dart';
import 'package:setec_app/core/classes/result_class.dart';
import 'package:setec_app/data/event/dto/event_dto.dart';
import 'package:setec_app/data/event/service/event_services.dart';
import 'package:setec_app/domain/models/event.dart';

class EventRepository extends BaseRepository<EventDTO> {
  EventRepository() 
  : super(
    storageKey: 'event',
    service: EventServices(),
  );

  Future<Result<List<Event>>> getTodasEvents() {
    return getAll<Event, EventDTO>();
  }

  Future<Result<Event>> buscarEventsPorId(int id) {
    return getById<Event, EventDTO>(id);
  }

  Future<Result<Event>> criarEvent(Event event) {
    return create<Event, EventDTO>(event);
  }

  Future<Result<Event>> atualizarEvent(Event event) {
    return update<Event, EventDTO>(event);
  }

  Future<Result<void>> deletarEvent(int id) {
    return delete(id);
  }
}
