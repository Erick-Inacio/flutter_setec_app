// import 'package:flutter/material.dart';

// class AuthViewModel extends ChangeNotifier {

//   AuthViewModel({
//     required 
//   })

//   void _buttomFunction(
//     BuildContext context,
//     MainProvider mainProvider,
//   ) async {
//     if (_formKey.currentState!.validate()) {
//       try {
//         UserApp userApp = UserApp.empty();

//         userApp.email = _emailController.text;
//         userApp.name = _nameController.text;

//         if (context.mounted) {
//           userApp.relationship =
//               Relationship.fromNameEnum(_relationship) as Relationship;
//           context.push(
//             '/createUser',
//             extra: {
//               "user": userApp,
//               "password": _passwordController.text,
//             },
//           );
//         }
//       } on Exception catch (e) {
//         logger.e('CreateAccount : $e');
//       }
//     }
//   }
// }
