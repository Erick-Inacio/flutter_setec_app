import 'package:flutter_dotenv/flutter_dotenv.dart';

class UserRoutes {
  static final String _baseUrl = '${dotenv.env['BASE_URL']}/api/user';

  //Basic Http verbs
  static final String post = "$_baseUrl/post";
  static String delete(int id) => "$_baseUrl/$id";

  //Others endpoints
  static String getById(String id) => "$_baseUrl/$id";
  static String getAllUsers = '$_baseUrl/getAll';
  static String getIdByUid(String uid) => "$_baseUrl/api/user/firebase/$uid";
}
