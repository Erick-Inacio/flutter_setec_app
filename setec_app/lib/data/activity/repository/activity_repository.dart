import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:setec_app/core/base/base_repository.dart';
import 'package:setec_app/core/classes/result_class.dart';
import 'package:setec_app/core/interface/basic_repository_crud.dart';
import 'package:setec_app/data/activity/dto/activity_dto.dart';
import 'package:setec_app/data/activity/mapping/activity_mapping.dart';
import 'package:setec_app/data/activity/service/activity_service.dart';
import 'package:setec_app/model/models/activity/activity.dart';

final typeActivityRepoProvider = Provider<ActivityRepository>((ref) {
  return ActivityRepository(); // classe com métodos utilitários, sem estado
});

class ActivityRepository extends BaseRepository<ActivityDTO>
    implements BasicRepositoryCRUD<Activity> {
  ActivityRepository()
      : super(
          storageKey: 'typeActivity',
          service: ActivityService(),
        );

  @override
  Future<Result<List<Activity>>> findAllData() {
    return getAll<Activity, ActivityDTO>();
  }

  @override
  Future<Result<List<Activity>>> findAllDataPaged(
      {int lastId = 0, int size = 10}) {
    return getAllPaged<Activity, ActivityDTO>(
      lastId: lastId,
      size: size,
    );
  }

  @override
  Future<Result<Activity>> findByDataId(int id) {
    return getById<Activity, ActivityDTO>(id);
  }

  @override
  Future<Result<Activity>> createData(Activity data) {
    return create<Activity, ActivityDTO>(
      domain: data,
      toDTO: (d) => d.toDTO(),
    );
  }

  @override
  Future<Result<Activity>> updateData(Activity data) {
    return update<Activity, ActivityDTO>(
      domain: data,
      toDTO: (d) => d.toDTO(),
    );
  }

  @override
  Future<Result<void>> deleteData(int id) {
    return delete(id);
  }
}
