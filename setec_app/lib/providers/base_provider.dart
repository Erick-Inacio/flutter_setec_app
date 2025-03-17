import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:setec_app/services/backend/base_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BaseProvider<T> extends ChangeNotifier {
  T? _data;
  final BaseService service;
  final String field;

  T? get data => _data;

  BaseProvider({required this.service, required this.field}) {
    _loadDataFromLocal();
  }

  Future<void> fetchData(int id) async {
    try {
      _data = await service.getById(id);
      await _saveDataToLocal(_data as T);
      notifyListeners();
    } catch (e) {
      throw Exception("Erro ao buscar os dados: $e");
    }
  }

  Future<void> _saveDataToLocal(T param) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(field, json.encode(param));
  }

  Future<void> _loadDataFromLocal() async {
    final prefs = await SharedPreferences.getInstance();
    String? jsonData = prefs.getString(field);

    if (jsonData != null) {
      _data = json.decode(jsonData) as T;
      notifyListeners();
    }
  }
}
