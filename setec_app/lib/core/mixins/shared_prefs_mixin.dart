import 'dart:convert';

import 'package:logger/web.dart';
import 'package:setec_app/core/classes/result_class.dart';
import 'package:shared_preferences/shared_preferences.dart';

mixin SharedPrefsMixin {
  Future<Result<void>> mixinSaveObject({
    required String key,
    required dynamic object,
  }) async {
    return handleResult(() async {
      Logger().i('Salvando o objeto localmente: ${object.toString()}');
      final json = object.toJson();
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(key, jsonEncode(json));
    });
  }

  Future<Result<void>> mixinSaveList({
    required String key,
    required List<dynamic> list,
  }) async {
    return handleResult(() async {
      final jsonList = list.map((e) => e.toJson()).toList();
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(key, jsonEncode(jsonList));
    });
  }

  Future<Result<void>> mixinAddToList({
    required String key,
    required Map<String, dynamic> newItem,
  }) async {
    return handleResult(() async {
      final prefs = await SharedPreferences.getInstance();
      final data = prefs.getString(key);

      List<Map<String, dynamic>> list = [];

      if (data != null) {
        final rawList = jsonDecode(data) as List;
        list = rawList.cast<Map<String, dynamic>>();
      }

      list.add(newItem);

      await prefs.setString(key, jsonEncode(list));
    });
  }

  Future<Result<Map<String, dynamic>?>> mixinGetObject(String key) async {
    return handleResult(() async {
      final prefs = await SharedPreferences.getInstance();
      final data = prefs.getString(key);
      if (data == null) return null;
      final decoded = jsonDecode(data);
      if (decoded is Map<String, dynamic>) return decoded;
      throw Exception('Objeto local mal formatado');
    });
  }

  Future<Result<List<Map<String, dynamic>>?>> mixinGetList(String key) async {
    return handleResult(() async {
      final prefs = await SharedPreferences.getInstance();
      final data = prefs.getString(key);
      if (data == null) return null;
      final rawList = jsonDecode(data) as List;
      return rawList.cast<Map<String, dynamic>>();
    });
  }

  Future<Result<void>> mixinRemove(String key) async {
    return handleResult(() async {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(key);
    });
  }

  Future<Result<void>> mixinRemoveFromListById({
    required String key,
    required dynamic id,
  }) async {
    return handleResult(() async {
      final prefs = await SharedPreferences.getInstance();
      final data = prefs.getString(key);
      if (data == null) return;
      final rawList = jsonDecode(data) as List;
      final updatedList = rawList.where((e) => e['id'] != id).toList();
      await prefs.setString(key, jsonEncode(updatedList));
    });
  }

  Future<Result<void>> mixinClearAll() async {
    return handleResult(() async {
      final prefs = await SharedPreferences.getInstance();
      await prefs.clear();
    });
  }
}
