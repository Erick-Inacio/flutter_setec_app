import 'package:flutter_dotenv/flutter_dotenv.dart';

class BaseRoutes {
  late String controllerName;

  BaseRoutes({required this.controllerName});

  // get all
  String getAll() =>baseUrl('getAll');

  // get by id
  String getById(int id) =>baseUrlWithParams('getById', {'id': id.toString()});

  // post
  String post() =>baseUrl('post');

  // put
  String put() =>baseUrl('put');

  // delete
  String delete(int id) => baseUrlWithParams('delete', {'id': id.toString()});

  // Método para adicionar parâmetros dinamicamente na URL
  String baseUrlWithParams(String path, Map<String, String> params) {
    final uri = Uri.parse('${dotenv.env['BASE_URL']}/api/$controllerName/$path')
        .replace(queryParameters: params);
    return uri.toString();
  }

  // Método para retornar URLs customizadas
  String custom(String endpoint, {Map<String, String>? params}) {
    return params == null
        ?baseUrl(endpoint)
        :baseUrlWithParams(endpoint, params);
  }

  // Método privado para retornar a URL base
  String baseUrl(String restPath) {
    return '${dotenv.env['BASE_URL']}/api/$controllerName/$restPath';
  }
}
