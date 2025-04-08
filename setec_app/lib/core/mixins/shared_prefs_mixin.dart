import 'dart:convert';

import 'package:logger/web.dart';
import 'package:setec_app/core/classes/result_class.dart';
import 'package:shared_preferences/shared_preferences.dart';

mixin SharedPrefsMixin {
  Future<Result<void>> saveObject({
    required String key,
    required dynamic object,
  }) async {
    return handleResult(() async {
      final json = object.toJson();
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(key, jsonEncode(json));
    }, onError: (e) {
      Logger().e('Erro ao salvar o objeto localmente: $e');
    });
  }

  Future<Result<void>> saveList({
    required String key,
    required List<dynamic> list,
  }) async {
    return handleResult(() async {
      final jsonList = list.map((e) => e.toJson()).toList();
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(key, jsonEncode(jsonList));
    }, onError: (e) {
      Logger().e('Erro ao salvar a lista localmente: $e');
    });
  }

  Future<Result<Map<String, dynamic>?>> getObject(String key) async {
    return handleResult(() async {
      final prefs = await SharedPreferences.getInstance();
      final data = prefs.getString(key);
      if (data == null) return null;
      final decoded = jsonDecode(data);
      if (decoded is Map<String, dynamic>) return decoded;
      throw Exception('Objeto local mal formatado');
    }, onError: (e) {
      Logger().e('Erro ao carregar o objeto localmente: $e');
    });
  }

  Future<Result<List<Map<String, dynamic>>?>> getList(String key) async {
    return handleResult(() async {
      final prefs = await SharedPreferences.getInstance();
      final data = prefs.getString(key);
      if (data == null) return null;
      final rawList = jsonDecode(data) as List;
      return rawList.cast<Map<String, dynamic>>();
    }, onError: (e) {
      Logger().e('Erro ao carregar a lista localmente: $e');
    });
  }

  Future<Result<void>> remove(String key) async {
    return handleResult(() async {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(key);
    }, onError: (e) {
      Logger().e('Erro ao remover o objeto localmente: $e');
    });
  }

  Future<Result<void>> clearAll() async {
    return handleResult(() async {
      final prefs = await SharedPreferences.getInstance();
      await prefs.clear();
    }, onError: (e) {
      Logger().e('Erro ao limpar os dados locais: $e');
    });
  }
}
