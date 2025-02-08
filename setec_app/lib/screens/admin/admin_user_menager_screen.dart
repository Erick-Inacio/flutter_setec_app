import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:logger/logger.dart';
import 'package:setec_app/models/user_app_model.dart';
import 'package:setec_app/services/backend/user_service.dart';
import 'package:setec_app/widgets/cards/user_card.dart';
import 'package:setec_app/widgets/iconButton/sign_out_icon_button.dart';

class AdminUserMenager extends StatefulWidget {
  const AdminUserMenager({super.key});

  @override
  State<AdminUserMenager> createState() => _AdminUserMenagerState();
}

class _AdminUserMenagerState extends State<AdminUserMenager> {
  List<UserApp?>? users;
  bool _isLoading = true;

  @override
  initState() {
    fetchAllUsers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Admin"),
        actions: <Widget>[
          // IconButton(
          //   icon: const Icon(Icons.home_filled),
          //   onPressed: () => context.go('/home'),
          // ),
          SignOutIconButton(parentContext: context),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: users?.length ?? 0,
              itemBuilder: (context, index) {
                return UserCard(
                  userApp: users![index],
                  onTap: () {
                    context.push('/user', extra: users![index]);
                  },
                );
              },
            ),
    );
  }

  Future<void> fetchAllUsers() async {
    UserServices userServices = UserServices();
    Logger logger = Logger();
    try {
      users = await userServices.getAllUsers();
      setState(() {
        _isLoading = false;
      });
    } on Exception catch (e, stacktrace) {
      logger.e('AdminPage: Erro ao buscar os usu arios: $e', stackTrace: stacktrace);
    }
  }
}
//erick.de.faria@hotmail.com
//admin123
