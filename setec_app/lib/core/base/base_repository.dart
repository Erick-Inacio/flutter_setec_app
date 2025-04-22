import 'package:flutter/material.dart';
import 'package:setec_app/core/base/base_service.dart';
import 'package:setec_app/core/classes/mappable_class.dart';
import 'package:setec_app/core/classes/result_class.dart';
import 'package:setec_app/core/mixins/shared_prefs_mixin.dart';

abstract class BaseRepository<DTO> with SharedPrefsMixin {
  BaseRepository({
    required BaseService<DTO> service,
    required String storageKey,
  })  : _service = service,
        _storageKey = storageKey;

  @protected
  final BaseService<DTO> _service;

  @protected
  final String _storageKey;

  Future<Result<List<Domain>>>
      getAll<Domain, AsDTO extends DTOConvertible<Domain>>() async {
    return handleResult(() async {
      final result = await _service.getAll();
      return _saveToLocalObjList(result);
    });
  }

  Future<Result<Domain>> getById<Domain, AsDTO extends DTOConvertible<Domain>>(
    int id,
  ) async {
    return handleResult(() async {
      final result = await _service.getById(id);

      return _saveToLocalObj(result);
    });
  }

  Future<Result<Domain>> create<Domain, AsDTO extends DTOConvertible<Domain>>({
    required Domain domain,
    required AsDTO Function(Domain) toDTO,
  }) async {
    return handleResult(() async {
      final convertedDto = toDTO(domain);

      final result = await _service.post(convertedDto as DTO);

      return _saveToLocalObj(result);
    });
  }

  Future<Result<Domain>> update<Domain, AsDTO extends DTOConvertible<Domain>>({
    required Domain domain,
    required AsDTO Function(Domain) toDTO,
  }) async {
    final convertedDto = toDTO(domain);

    final result = await _service.put(convertedDto as DTO);

    return _saveToLocalObj(result);
  }

  Future<Result<void>> delete(int id) async {
    return handleResult(() async {
      await _service.delete(id);

      await mixinRemove(_storageKey);
    });
  }

  //SharedPreferences
  Future<Result<void>> saveObjectLocal(DTO d) async {
    return handleResult(() async {
      await mixinSaveObject(key: _storageKey, object: d);
    });
  }

  Future<Result<void>> saveListLocal(List<dynamic> list, {String? key}) async {
    return handleResult(() async {
      await mixinSaveList(key: key ?? _storageKey, list: list);
    });
  }

  Future<Result<Map<String, dynamic>?>> getObjectLocal() async {
    return handleResult(() async {
      final result = await mixinGetObject(_storageKey);
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
      final result = await mixinGetList(_storageKey);
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
      await mixinRemove(_storageKey);
    });
  }

  Future<Domain> _saveToLocalObj<Domain, AsDTO>(Result result) async {
    switch (result) {
      case Ok(value: final dto):
        {
          final domainEntity = dto.toDomain();

          final result = await saveObjectLocal(dto);

          switch (result) {
            case Ok():
              return domainEntity;
            case Error(error: final e):
              throw e;
          }
        }
      case Error(error: final e):
        throw e;
    }
  }

  Future<List<Domain>>
      _saveToLocalObjList<Domain, AsDTO extends DTOConvertible<Domain>>(
    Result result,
  ) async {
    switch (result) {
      case Ok(value: final listDto):
        {
          // Cast seguro
          final domainEntity =
              (listDto as List<AsDTO>).map((e) => e.toDomain()).toList();

          final saveResult = await saveListLocal(listDto);

          switch (saveResult) {
            case Ok():
              return domainEntity;
            case Error(error: final e):
              throw e;
          }
        }
      case Error(error: final e):
        throw e;
    }
  }
}
