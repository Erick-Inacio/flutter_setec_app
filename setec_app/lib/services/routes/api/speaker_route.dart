class SpeakerRoutes{
  static final String _baseUrl = 'http://192.168.54.79:8080';

  //Rest Verbs
  static final String post = "$_baseUrl/api/speaker";
  static final String put = "$_baseUrl/api/speaker";

  static String getById(String id) => "$_baseUrl/api/speaker/$id";
  static String getAllUsers() => "$_baseUrl/api/speaker";

}