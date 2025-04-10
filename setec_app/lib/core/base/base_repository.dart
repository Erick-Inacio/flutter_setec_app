import 'package:flutter/material.dart';
import 'package:logger/web.dart';
import 'package:setec_app/core/base/base_service.dart';
import 'package:setec_app/core/classes/mappable_class.dart';
import 'package:setec_app/core/classes/result_class.dart';
import 'package:setec_app/core/mixins/shared_prefs_mixin.dart';

abstract class BaseRepository<T> with SharedPrefsMixin {
  BaseRepository({
    required BaseService<T> service,
    required String storageKey,
  })  : _service = service,
        _storageKey = storageKey;

  @protected
  final BaseService<T> _service;

  @protected
  final String _storageKey;

  Future<Result<List<D>>> getAll<D, DTO extends DTOConvertible<D>>() async {
    return handleResult(() async {
      final result = await _service.getAll();

      switch (result) {
        case Ok(value: final list):
          {
            final domainList = list.map<D>((dto) {
              return (dto as DTO).toDomain();
            }).toList();

            await saveList(
              key: _storageKey,
              list: domainList,
            );

            return domainList;
          }
        case Error(error: final e):
          throw e;
      }
    }, onError: (e) {
      Logger().e('Erro ao carregar ou salvar localmente a lista: $e');
    });
  }

  Future<Result<D>> getById<D, DTO extends DTOConvertible<D>>(
    int id,
  ) {
    return handleResult(() async {
      final result = await _service.getById(id);

      switch (result) {
        case Ok(value: final dto):
          {
            final domainEntity = (dto as DTO).toDomain();

            await saveObject(
              key: _storageKey,
              object: domainEntity,
            );

            return domainEntity;
          }
        case Error(error: final e):
          {
            throw e;
          }
      }
    }, onError: (e) {
      Logger().e('Erro ao buscar por id ou salavr localmente: $e');
    });
  }

  Future<Result<D>> create<D, DTO extends DTOConvertible<D>>(D domain) async {
    return handleResult(() async {
      final convertedDto = (domain as dynamic).toDTO();

      final result = await _service.post(convertedDto);

      switch (result) {
        case Ok(value: final dto):
          {
            final domainEntity = (dto as DTO).toDomain();

            await saveObject(
              key: _storageKey,
              object: domainEntity,
            );

            return domainEntity;
          }
        case Error(error: final e):
          throw e;
      }
    }, onError: (e) {
      Logger().e('Erro ao criar ou salvar localmente: $e');
    });
  }

  Future<Result<D>> update<D, DTO extends DTOConvertible<D>>(D domain) async {
    return handleResult(() async {
      final convertedDto = (domain as dynamic).toDTO();

      final result = await _service.put(convertedDto);

      switch (result) {
        case Ok(value: final dto):
          {
            final domainEntity = (dto as DTO).toDomain();

            await saveObject(
              key: _storageKey,
              object: domainEntity,
            );

            return domainEntity;
          }
        case Error(error: final e):
          throw e;
      }
    });
  }

  Future<Result<void>> delete(int id) async {
    return handleResult(() async {
      await _service.delete(id);

      await remove(_storageKey);
    }, onError: (e) {
      Logger().e('Erro ao deletar ou excluir localmente: $e');
    });
  }

  //SharedPreferences
  Future<Result<void>> saveObjectLocal(T d) async {
    return handleResult(() async {
      await saveObject(key: _storageKey, object: d);
    });
  }

  Future<Result<void>> saveListLocal(List<dynamic> list, {String? key}) async {
    return handleResult(() async {
      await saveList(key: key ?? _storageKey, list: list);
    }, onError: (e) {
      Logger().e('Erro ao salvar a lista localmente: $e');
    });
  }

  Future<Result<Map<String, dynamic>?>> getObjectLocal() async {
    return handleResult(() async {
      final result = await getObject(_storageKey);
      switch (result) {
        case Ok(value: final value):
          return value;
        case Error(error: final e):
          throw e;
      }
    });
  }

  Future<Result<List<Map<String, dynamic>>?>> getListObject() async {
    return handleResult(() async {
      final result = await getList(_storageKey);
      switch (result) {
        case Ok(value: final value):
          return value;
        case Error(error: final e):
          throw e;
      }
    });
  }

  Future<Result<void>> removeLocal() async {
    return handleResult(() async {
      await remove(_storageKey);
    });
  }
}
