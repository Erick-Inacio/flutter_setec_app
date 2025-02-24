import 'package:flutter_dotenv/flutter_dotenv.dart';

class UserRoutes{
  static final String? _baseUrl = dotenv.env['BASE_URL'];

  //Basic Http verbs
  static final String post = "$_baseUrl/api/user";
  static String delete(int id) => "$_baseUrl/api/user/$id";

  //Others eendpoints
  static String getById(String id) => "$_baseUrl/api/user/$id";
  static String getAllUsers() => "$_baseUrl/api/user";
  static String getIdByUid(String uid) => "$_baseUrl/api/user/firebase/$uid";

}