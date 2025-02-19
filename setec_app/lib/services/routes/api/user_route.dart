class UserRoutes{
  static final String _baseUrl = 'http://192.168.54.79:8080';
  static final String post = "$_baseUrl/api/user";

  static String getById(String id) => "$_baseUrl/api/user/$id";
  static String getAllUsers() => "$_baseUrl/api/user";

  static String getIdByUid(String uid) => "$_baseUrl/api/user/firebase/$uid";

}