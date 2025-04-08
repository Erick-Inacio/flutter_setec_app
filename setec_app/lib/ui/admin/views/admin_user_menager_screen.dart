import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:logger/logger.dart';
import 'package:setec_app/data/userApp/service/user_services.dart';
import 'package:setec_app/ui/core/ui/widgets/cards/user_card.dart';
import 'package:setec_app/ui/core/ui/widgets/iconButton/sign_out_icon_button.dart';

class AdminUserManager extends StatefulWidget {
  const AdminUserManager({super.key});

  @override
  State<AdminUserManager> createState() => _AdminUserManagerState();
}

class _AdminUserManagerState extends State<AdminUserManager> {
  List<dynamic>? users;
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
          SignOutIconButton(),
        ],
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
            shrinkWrap: true,
              itemCount: users?.length ?? 0,
              itemBuilder: (context, index) {
                return UserCard(
                  userApp: users![index],
                  onTap: () {
                    context.push(
                      '/user',
                      extra: {
                        'user': users![index],
                        'context': null,
                      },
                    );
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
      users = await userServices.getAll();
      logger.i('AdminPage: Usuários buscados com sucesso: ${users?.length}');
      setState(() {
        _isLoading = false;
      });
    } on Exception catch (e, stacktrace) {
      logger.e('AdminPage: Erro ao buscar os usuários: $e',
          stackTrace: stacktrace);
    }
  }
}
//erick.de.faria@hotmail.com
//admin123
