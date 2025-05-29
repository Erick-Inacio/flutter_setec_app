import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:setec_app/core/base/base_repository.dart';
import 'package:setec_app/core/classes/result_class.dart';
import 'package:setec_app/core/interface/basic_repository_crud.dart';
import 'package:setec_app/data/typeActivity/dto/type_activity_dto.dart';
import 'package:setec_app/data/typeActivity/mapping/type_activity_mapping.dart';
import 'package:setec_app/data/typeActivity/service/type_activity_service.dart';
import 'package:setec_app/model/models/typeActivity/type_activity.dart';

final typeActivityRepoProvider = Provider<TypeActivityRepository>((ref) {
  return TypeActivityRepository(); // classe com métodos utilitários, sem estado
});

class TypeActivityRepository extends BaseRepository<TypeActivityDTO>
    implements BasicRepositoryCRUD<TypeActivity> {
  TypeActivityRepository()
      : super(
          storageKey: 'typeActivity',
          service: TypeActivityService(),
        );

  @override
  Future<Result<List<TypeActivity>>> findAllData() {
    return getAll<TypeActivity, TypeActivityDTO>();
  }

  @override
  Future<Result<List<TypeActivity>>> findAllDataPaged(
      {int lastId = 0, int size = 10}) {
    return getAllPaged<TypeActivity, TypeActivityDTO>(
      lastId: lastId,
      size: size,
    );
  }

  @override
  Future<Result<TypeActivity>> findByDataId(int id) {
    return getById<TypeActivity, TypeActivityDTO>(id);
  }

  @override
  Future<Result<TypeActivity>> createData(TypeActivity data) {
    return create<TypeActivity, TypeActivityDTO>(
      domain: data,
      toDTO: (d) => d.toDTO(),
    );
  }

  @override
  Future<Result<TypeActivity>> updateData(TypeActivity data) {
    return update<TypeActivity, TypeActivityDTO>(
      domain: data,
      toDTO: (d) => d.toDTO(),
    );
  }

  @override
  Future<Result<void>> deleteData(int id) {
    return delete(id);
  }
}
