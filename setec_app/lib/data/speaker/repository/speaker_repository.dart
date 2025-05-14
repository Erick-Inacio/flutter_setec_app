import 'package:riverpod/riverpod.dart';
import 'package:setec_app/core/base/base_repository.dart';
import 'package:setec_app/core/classes/app_exception_class.dart';
import 'package:setec_app/core/classes/result_class.dart';
import 'package:setec_app/core/interface/basic_repository_crud.dart';
import 'package:setec_app/data/speaker/dto/speaker_dto.dart';
import 'package:setec_app/data/speaker/mapper/speaker_mapper.dart';
import 'package:setec_app/data/speaker/service/speaker_services.dart';
import 'package:setec_app/model/models/speaker.dart';

final speakerRepository =
    Provider<SpeakerRepository>((ref) => SpeakerRepository());

class SpeakerRepository extends BaseRepository<SpeakerDTO>
    implements BasicRepositoryCRUD<Speaker> {
  SpeakerRepository()
      : super(
          storageKey: 'speaker',
          service: SpeakerServices(),
        );

  @override
  Future<Result<List<Speaker>>> findAllData() {
    return getAll<Speaker, SpeakerDTO>();
  }

  @override
  Future<Result<List<Speaker>>> findAllDataPaged(
      {int lastId = 1, int size = 10}) {
    return getAllPaged<Speaker, SpeakerDTO>(lastId: lastId, size: size);
  }

  @override
  Future<Result<Speaker>> findByDataId(int id) {
    return getById<Speaker, SpeakerDTO>(id);
  }

  @override
  Future<Result<Speaker>> createData(Speaker speaker) {
    return create<Speaker, SpeakerDTO>(
        domain: speaker, toDTO: (d) => d.toDTO());
  }

  @override
  Future<Result<Speaker>> updateData(Speaker speaker) {
    return update<Speaker, SpeakerDTO>(
        domain: speaker, toDTO: (d) => d.toDTO());
  }

  @override
  Future<Result<void>> deleteData(int id) {
    return delete(id);
  }

  Future<Result<Speaker>> getByUserApp(int id) async {
    return handleResult(() async {
      final response = await SpeakerServices().getByUser(id);

      switch (response) {
        case Ok(value: final speakerDTO):
          return speakerDTO.toDomain();
        case Error(error: final e):
          throw e is AppException
              ? e
              : AppException("Erro ao buscar palestrante: $e", statusCode: 500);
      }
    });
  }

  Future<Result<void>> approveSpeaker(Speaker speaker) async {
    return handleResult(
      () async {
        final updatedSpeaker = await SpeakerServices().put(speaker.toDTO());

        if (updatedSpeaker case Error(error: final e)) throw e;
      },
    );
  }
}
