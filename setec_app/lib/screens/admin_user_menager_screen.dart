import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:setec_app/models/user_app_model.dart';
import 'package:setec_app/services/backend/user_service.dart';
import 'package:setec_app/widgets/cards/user_card.dart';

class AdminUserMenager extends StatefulWidget {
  const AdminUserMenager({super.key});

  @override
  State<AdminUserMenager> createState() => _AdminUserMenagerState();
}

class _AdminUserMenagerState extends State<AdminUserMenager> {
  @override
  Widget build(BuildContext context) {
    bool isLoading = true;
    List<UserApp?>? users;

    // Logger logger = Logger();

    Future<void> init() async {
      try {
        final usersList = await fetchAllUsers(null);
        if (usersList == null) {
          throw Exception("Erro ao buscar os usu arios");
        }

        setState(() {
          users = usersList;
          isLoading = false;
        });
      } on Exception catch (e, stacktrace) {
        Logger().e("Erro ao buscar os usu arios: $e", stackTrace: stacktrace);
      }
    }

    @override
    // ignore: unused_element
    void initState() {
      super.initState();
      init();
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Admin User Manager"),
        centerTitle: true,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : users!.isEmpty
              ? const Center(child: Text("Nenhum usuário cadastrado"))
              : ListView.builder(
                  itemCount: users!.length,
                  itemBuilder: (BuildContext context, int index) {
                    return UserCard(userApp: users![index]);
                  },
                ),
    );
  }

  Future<List<UserApp?>?> fetchAllUsers(List<UserApp?>? users) async {
    UserServices userServices = UserServices();
    Logger logger = Logger();
    try {
      users = await userServices.getAllUsers();
      if (users == null) {
        return <UserApp?>[];
      }
    } on Exception catch (e, stacktrace) {
      logger.e("Erro ao buscar os usu arios: $e", stackTrace: stacktrace);
      return <UserApp?>[];
    }
    return users;
  }
}
