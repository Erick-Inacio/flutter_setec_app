import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:setec_app/core/base/base_repository.dart';
import 'package:setec_app/core/classes/result_class.dart';
import 'package:setec_app/core/interface/basic_repository_crud.dart';
import 'package:setec_app/data/userApp/dto/user_app_dto.dart';
import 'package:setec_app/data/userApp/mapper/user_app_mapper.dart';
import 'package:setec_app/data/userApp/service/user_services.dart';
import 'package:setec_app/model/models/user_app.dart';

  final userAppRepository = Provider<UserAppRepository>((ref) => UserAppRepository());

class UserAppRepository extends BaseRepository<UserAppDTO>
    implements BasicRepositoryCRUD<UserApp> {
  UserAppRepository()
      : super(
          storageKey: 'userApp',
          service: UserServices(),
        );

  @override
  Future<Result<UserApp>> createData(UserApp data) {
    return create<UserApp, UserAppDTO>(domain: data, toDTO: (data) => data.toDTO());
  }

  @override
  Future<Result<void>> deleteData(int id) {
    return delete(id);
  }

  @override
  Future<Result<List<UserApp>>> findAllData() {
    return getAll<UserApp, UserAppDTO>();
  }

  @override
  Future<Result<UserApp>> findByDataId(int id) {
    return getById<UserApp, UserAppDTO>(id);
  }

  @override
  Future<Result<UserApp>> updateData(UserApp data) {
    return update<UserApp, UserAppDTO>(domain: data, toDTO: (data) => data.toDTO());
  }
  
  @override
  Future<Result<List<UserApp>>> findAllDataPaged({int lastId = 1, int size = 10}) {
    return getAllPaged<UserApp, UserAppDTO>(lastId: lastId, size: size);
  }

  // Future<Result<UserApp>> findByUid(String uid) {
  //   return handleResult(() async {
  //     final result = await UserServices().getByUid(uid);

  //     switch (result) {
  //       case Ok(value: final userAppDTO):
  //         final userApp = userAppDTO.toDomain();

  //         await mixinSaveObject(
  //           key: 'userApp',
  //           object: userApp,
  //         );

  //         return userAppDTO.toDomain();
  //       case Error(error: final e):
  //         throw e is AppException
  //             ? e
  //             : AppException("Erro ao buscar usuário: $e", statusCode: 500);
  //     }
  //   });
  // }
}
