import 'package:setec_app/core/config/app_config.dart';

class BaseRoutes {
  late String controllerName;
  final _url = AppConfig.fullApiUrl;

  BaseRoutes({required this.controllerName});

  // get all
  String getAllPaged() => _baseUrl('getallpaged');
  String getAll() => _baseUrl('getall');

  // get by id
  String getById(int id) =>
      _baseUrlWithParams('getbyid', {'id': id.toString()});

  // post
  String post() => _baseUrl('post');

  // put
  String put() => _baseUrl('put');

  // delete
  String delete(int id) => _baseUrlWithParams('delete', {'id': id.toString()});

  // Método para adicionar parâmetros dinamicamente na URL
  String _baseUrlWithParams(String path, Map<String, String> params) {
    final uri = Uri.parse('$_url/api/$controllerName/v1/$path')
        .replace(queryParameters: params);
    return uri.toString();
  }

  // Método para retornar URLs customizadas
  String custom({required String endpoint, Map<String, String>? params}) {
    return params == null
        ? _baseUrl(endpoint)
        : _baseUrlWithParams(endpoint, params);
  }

  // Método privado para retornar a URL base
  String _baseUrl(String restPath) {
    return '$_url/api/$controllerName/v1/$restPath';
  }
}
