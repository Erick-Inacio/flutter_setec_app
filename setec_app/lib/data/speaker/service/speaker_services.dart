import 'package:dio/dio.dart';
import 'package:logger/web.dart';
import 'package:setec_app/core/base/base_service.dart';
import 'package:setec_app/core/classes/result_class.dart';
import 'package:setec_app/data/core/endpoints/speaker_routes.dart';
import 'package:setec_app/data/speaker/dto/speaker_dto.dart';

class SpeakerServices extends BaseService<SpeakerDTO> {
  SpeakerServices()
      : super(
          apiRoute: SpeakerRoutes(),
          fromJson: SpeakerDTO.fromJson,
          toJson: (speaker) => speaker.toJson(),
        );

  final Dio _dio = Dio();

  Future<Result<SpeakerDTO>> getByUser(int userId) async {
    return handleResult(() async {
      final routes = SpeakerRoutes();
      final result = await getAuthHeaders();

      switch (result) {
        case Ok(value: final header):
          Logger().i(header);

          final response = await _dio.get(
            routes.getByUser(userId),
            options: Options(headers: header),
          );
          final data = response.data as Map<String, dynamic>;
          return SpeakerDTO.fromJson(data);
        case Error(error: final e):
          throw e;
      }
    });
  }
}
