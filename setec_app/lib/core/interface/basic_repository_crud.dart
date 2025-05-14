import 'package:setec_app/core/classes/result_class.dart';

abstract class BasicRepositoryCRUD<T> {
  Future<Result<List<T>>> findAllDataPaged({int lastId, int size});
  Future<Result<List<T>>> findAllData();
  Future<Result<T>> findByDataId(int id);
  Future<Result<T>> createData(T data);
  Future<Result<T>> updateData(T data);
  Future<Result<void>> deleteData(int id);  
}