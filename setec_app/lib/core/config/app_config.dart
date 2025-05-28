import 'package:flutter_dotenv/flutter_dotenv.dart';

class AppConfig {
  static String get _baseUrl => dotenv.env['BASE_URL'] ?? 'http://localhost';
  // static String get _port => dotenv.env['PORT'] ?? '8080';

  // static String get fullApiUrl => '$_baseUrl:$_port/api';
  static String get fullApiUrl => _baseUrl;
}