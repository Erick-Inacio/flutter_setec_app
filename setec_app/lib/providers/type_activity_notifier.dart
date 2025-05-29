import 'package:riverpod/riverpod.dart';
import 'package:setec_app/core/classes/result_class.dart';
import 'package:setec_app/core/mixins/shared_prefs_mixin.dart';
import 'package:setec_app/data/typeActivity/repository/type_activity_repository.dart';
import 'package:setec_app/model/models/typeActivity/type_activity.dart';

class TypeActivityNotifier extends Notifier<List<TypeActivity>>
    with SharedPrefsMixin {
  late final TypeActivityRepository _repository;

  @override
  List<TypeActivity> build() {
    _repository = ref.read(typeActivityRepoProvider);
    return [];
  }

  Future<Result<void>> fetchTypeActivities() async {
    return handleResult(() async {
      final result = await _repository.getAll();

      switch (result) {
        case Ok(value: final typeActivities):
          final castedList = (typeActivities).cast<TypeActivity>();
          state = castedList;
          final saveResult = await mixinSaveList(
            key: 'typeActivities',
            list: typeActivities,
          );
          if (saveResult is Error) throw saveResult.error;
          break;
        case Error(error: final e):
          throw e;
      }
    });
  }

  Future<Result<TypeActivity>> addTypeActivity(
      TypeActivity typeActivity) async {
    return handleResult(() async {
      final result = await _repository.createData(typeActivity);
      switch (result) {
        case Ok(value: final createdTypeActivity):
          state = [...state, createdTypeActivity];
          final saveResult = await mixinAddToList(
            key: 'typeActivities',
            newItem: createdTypeActivity.toJson(),
          );
          if (saveResult is Error) throw saveResult.error;
          return createdTypeActivity;
        case Error(error: final e):
          throw e;
      }
    });
  }
}
