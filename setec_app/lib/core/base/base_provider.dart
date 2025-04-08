import 'package:flutter/material.dart';
import 'package:logger/web.dart';
import 'package:setec_app/core/classes/result_class.dart';

class BaseProvider<T> extends ChangeNotifier {
  BaseProvider();

  T? _data;
  T? get data => _data;

  Future<Result<void>> updateData(T data) async {
    return handleResult(() async {
      _data = data;
      notifyListeners();
    }, onError: (e) {
      Logger().e('Erro ao atualizar os dados no provider: $e');
    });
  }

  Future<Result<void>> clearData() async {
    return handleResult(() async {
      _data = null;
      notifyListeners();
    }, onError: (e) {
      Logger().e('Erro ao limpar os dados no provider: $e');
    });
  }
}
