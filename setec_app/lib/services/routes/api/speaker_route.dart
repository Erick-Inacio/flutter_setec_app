class SpeakerRoutes{
  static final String _baseUrl = 'http://172.31.160.1:8080';

  //Rest Verbs
  static final String post = "$_baseUrl/api/speaker";
  static final String put = "$_baseUrl/api/speaker";

  static String getById(String id) => "$_baseUrl/api/speaker/$id";
  static String getAllUsers() => "$_baseUrl/api/speaker";

}