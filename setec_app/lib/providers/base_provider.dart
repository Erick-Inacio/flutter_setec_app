import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:logger/web.dart';
import 'package:setec_app/services/backend/base_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BaseProvider<T> extends ChangeNotifier {
  T? _data;
  final BaseService service;
  final String field;
  final T Function(Map<String, dynamic>) fromJson;
  final Map<String, dynamic> Function(T) toJson;

  Logger logger = Logger();

  T? get data => _data;

  BaseProvider({
    required this.service,
    required this.field,
    required this.fromJson,
    required this.toJson,
  });

  Future<void> fetchData(int id) async {
    try {
      _data = await service.getById(id);
      await saveDataToLocal(_data as T);
      notifyListeners();
    } catch (e) {
      logger.e('Erro ao buscar os dados: $e');
      rethrow;
    }
  }

  Future<void> saveDataToLocal(T t) async {
    late SharedPreferences prefs;

    try {
      prefs = await SharedPreferences.getInstance();
      await prefs.setString(field, jsonEncode(toJson(t)));
      await prefs.setString('dataType', field);
    } on Exception catch (e) {
      logger.e('Erro ao salvar os dados: $e');
      prefs.remove(field);
      prefs.remove('dataType');
      rethrow;
    }
  }

  Future<Map<String, dynamic>?> loadDataFromLocal() async {
    late SharedPreferences prefs;
    try {
      prefs = await SharedPreferences.getInstance();
      final restoredData = prefs.getString(field);

      if (restoredData != null) {
        return jsonDecode(restoredData);
      }
      return null;
    } on Exception catch (e) {
      logger.e('Erro ao carregar os dados: $e');
      prefs.remove(field);
      prefs.remove('dataType');
      rethrow;
    }
  }
}
