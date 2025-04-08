import 'package:dio/dio.dart';
import 'package:logger/web.dart';
import 'package:setec_app/core/base/base_service.dart';
import 'package:setec_app/core/classes/result_class.dart';
import 'package:setec_app/data/event/dto/event_dto.dart';
import 'package:setec_app/data/firebase/auth/auth_repository.dart';
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
      final token = await AuthRepository().getUserToken();

      final response = await _dio.get(
        EventRoutes().getActivitiesByEventId(userId),
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json'
          },
        ),
      );

      final data = response.data as List;
      return data.map((e) => EventDTO.fromJson(e)).toList();
    }, onError: (e) {
      Logger().e('Erro ao buscar atividades por evento: $e');
    });
  }

  Future<Result<List<EventDTO>>> getEventsWithNoAuth() async {
    return handleResult(() async {
      final response = await _dio.get(
        EventRoutes().getAll(),
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
