import 'package:flutter_dotenv/flutter_dotenv.dart';

class BaseRoutes {
  late String controllerName;

  BaseRoutes({required this.controllerName});

  // get all
  String getAll() => _baseUrl('getAll');

  // get by id
  String getById(int id) => _baseUrlWithParams('getById', {'id': id.toString()});

  // post
  String post() => _baseUrl('post');

  // put
  String put() => _baseUrl('put');

  // delete
  String delete(int id) => _baseUrlWithParams('delete', {'id': id.toString()});

  // Método para adicionar parâmetros dinamicamente na URL
  String _baseUrlWithParams(String path, Map<String, String> params) {
    final uri = Uri.parse('${dotenv.env['BASE_URL']}/api/$controllerName/$path')
        .replace(queryParameters: params);
    return uri.toString();
  }

  // Método para retornar URLs customizadas
  String custom(String endpoint, {Map<String, String>? params}) {
    return params == null
        ? _baseUrl(endpoint)
        : _baseUrlWithParams(endpoint, params);
  }

  // Método privado para retornar a URL base
  String _baseUrl(String restPath) {
    return '${dotenv.env['BASE_URL']}/api/$controllerName/$restPath';
  }
}
