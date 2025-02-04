class UserRoutes{
  static const String _baseUrl = "http://192.168.31.109:8080";
  static const String post = "$_baseUrl/api/user";

  static String getById(String id) => "$_baseUrl/api/user/$id";
  static String getAllUsers() => "$_baseUrl/api/user";

  static String getIdByUid(String uid) => "$_baseUrl/api/user/firebase/$uid";

}

// class UserRoutes{
//   static const String _baseUrl = "http://192.168.31.20:8080";
//   static const String post = "$_baseUrl/api/user";

//   static String getById(String id) => "$_baseUrl/api/user/$id";
//   static String getAllUsers() => "$_baseUrl/api/user";

//   static String getIdByUid(String uid) => "$_baseUrl/api/user/firebase/$uid";

// }