import 'package:flutter/material.dart';
import 'package:logger/web.dart';
import 'package:setec_app/core/classes/result_class.dart';

mixin ListEditingMixin<T> on ChangeNotifier {
  List<T>? _datas;

  List<T>? get datas => _datas == null ? null : List.unmodifiable(_datas!);
  set datas(List<T>? value) => _datas = value;

  Future<Result<void>> addItem(T item) {
    return handleResult(() async {
      _datas ??= [];
      _datas!.add(item);
      notifyListeners();
    }, onError: (e) {
      Logger().i('Item adicionado com sucesso: $item');
    });
  }

  Future<Result<void>> setList(List<T> list) {
    return handleResult(() async {
      _datas = list;
      notifyListeners();
    }, onError: (e) {
      Logger().i('Lista atualizada com sucesso: $list');
    });
  }

  Future<Result<void>> removeItem(bool Function(T) condition) {
    return handleResult(() async {
      _datas?.removeWhere(condition);
      notifyListeners();
    }, onError: (e) {
      Logger().i('Item removido com sucesso');
    });
  }

  Future<Result<void>> clearList() {
    return handleResult(() async {
      _datas = [];
      notifyListeners();
    }, onError: (e) {
      Logger().i('Lista limpa com sucesso');
    });
  }
}
