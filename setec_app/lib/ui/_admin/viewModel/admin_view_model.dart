// import 'package:flutter/material.dart';
// import 'package:logger/logger.dart';
// import 'package:setec_app/core/classes/result_class.dart';
// import 'package:setec_app/data/userApp/service/user_services.dart';

// class AdminViewModel extends ChangeNotifier {
//   Future<Result<void>> fetchAllUsers(Function<bool>() setState, List<dynamic>? list) async {
//     return handleResult(() async {
//       UserServices userServices = UserServices();
//       Logger logger = Logger();
//       try {
//         users = await userServices.getAllPaged();
//         logger.i('AdminPage: Usuários buscados com sucesso: ${users?.length}');
//         setState(() {
//           _isLoading = false;
//         });
//       } on Exception catch (e, stacktrace) {
//         logger.e('AdminPage: Erro ao buscar os usuários: $e',
//             stackTrace: stacktrace);
//       }
//     });
//   }
// }
