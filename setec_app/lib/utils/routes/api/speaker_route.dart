import 'package:flutter_dotenv/flutter_dotenv.dart';

class SpeakerRoutes{
  static final String? _baseUrl = dotenv.env['BASE_URL'];

  //Rest Verbs
  static final String post = "$_baseUrl/api/speaker";
  static final String put = "$_baseUrl/api/speaker";

  static String getById(String id) => "$_baseUrl/api/speaker/$id";
  static String getAllUsers() => "$_baseUrl/api/speaker";
  static String getSpeakerByUserId(int userId) => "$_baseUrl/api/speaker/findUser/$userId";

}