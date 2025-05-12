import 'package:dio/dio.dart';
import 'package:logger/web.dart';
import 'package:setec_app/core/base/base_service.dart';
import 'package:setec_app/core/classes/result_class.dart';
import 'package:setec_app/data/event/dto/event_dto.dart';
import 'package:setec_app/data/core/endpoints/event_routes.dart';

class EventServices extends BaseService<EventDTO> {
  EventServices()
      : super(
          apiRoute: EventRoutes(),
          fromJson: EventDTO.fromJson,
          toJson: (event) => event.toJson(),
        );

  final Dio _dio = Dio();

  Future<Result<List<EventDTO>>> getActivitiesByEventId(int userId) async {
    return handleResult(() async {
      final result = await getAuthHeaders();

      switch (result) {
        case Ok(value: final header):
          final response = await _dio.get(
            EventRoutes().getActivitiesByEventId(userId),
            options: Options(
              headers: header,
            ),
          );
          final data = response.data as List;
          return data.map((e) => EventDTO.fromJson(e)).toList();
        case Error(error: final e):
          throw e;
      }
    });
  }

  Future<Result<List<EventDTO>>> getEventsWithNoAuth() async {
    //FIXME: corrigir pois deve enviar um token anonimo e n acessar enpoint publico
    
    return handleResult(() async {
      final response = await _dio.get(
        EventRoutes().getAllPaged(),
        options: Options(
          headers: {'Content-Type': 'application/json'},
        ),
      );

      if (response.statusCode == 204) {
        return [];
      }

      final data = response.data as List;
      return data.map((e) => EventDTO.fromJson(e)).toList();
    }, onError: (e) {
      Logger().e('Erro ao buscar eventos sem auth: $e');
    });
  }
}
