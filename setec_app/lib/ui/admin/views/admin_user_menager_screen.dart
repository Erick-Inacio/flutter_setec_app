// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';
// import 'package:setec_app/ui/utils/ui/widgets/cards/user_card.dart';
// import 'package:setec_app/ui/utils/ui/widgets/iconButton/sign_out_icon_button.dart';


// class AdminUserManager extends StatefulWidget {
//   const AdminUserManager({super.key});

//   @override
//   State<AdminUserManager> createState() => _AdminUserManagerState();
// }

// class _AdminUserManagerState extends State<AdminUserManager> {
//   List<dynamic>? users;
//   bool _isLoading = true;

//   @override
//   initState() {
//     fetchAllUsers((setstate){} , users);
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: ListenableBuilder(
//         listenable: ,
//         child: Scaffold(
//           appBar: AppBar(
//             title: const Text("Admin"),
//             actions: <Widget>[
//               SignOutIconButton(),
//             ],
//           ),
//           body: _isLoading
//               ? const Center(
//                   child: CircularProgressIndicator(),
//                 )
//               : ListView.builder(
//                 shrinkWrap: true,
//                   itemCount: users?.length ?? 0,
//                   itemBuilder: (context, index) {
//                     return UserCard(
//                       userApp: users![index],
//                       onTap: () {
//                         context.push(
//                           '/user',
//                           extra: {
//                             'user': users![index],
//                             'context': null,
//                           },
//                         );
//                       },
//                     );
//                   },
//                 ),
//         ),
//       ),
//     );
//   }
// }
// //erick.de.faria@hotmail.com
// //admin123
