import 'package:flutter/material.dart';
import 'package:setec_app/models/user_app_model.dart';
import 'package:setec_app/widgets/Text/Field/info_text_field.dart';

class UserScreen extends StatefulWidget {
  final UserApp user;

  UserScreen({super.key, required this.user});

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  late TextEditingController raController = TextEditingController();
  late TextEditingController emailController = TextEditingController();
  late TextEditingController roleController = TextEditingController();
  late TextEditingController relationshipController = TextEditingController();
  UserApp? userApp;

  @override
  void initState() {
    userApp = widget.user;
    if (userApp != null) {
      raController.text = userApp!.ra;
      emailController.text = userApp!.email;
      roleController.text = userApp!.role.displayName;
      relationshipController.text = userApp!.relationship.displayName;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(userApp != null ? userApp!.name : "Usuário"),
      ),
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(16.0),
              height: MediaQuery.of(context).size.height * 0.3,
              child: CircleAvatar(
                backgroundColor: Colors.deepPurple,
                radius: 60,
                child: Icon(
                  Icons.person,
                  size: 80,
                  color: Colors.white,
                ),
              ),
            ),
            InfoTextField(
              info: 'RA',
              controller: raController,
            ),
            SizedBox(height: 16),
            InfoTextField(
              info: 'Email',
              controller: emailController,
            ),
            SizedBox(height: 16),
            InfoTextField(
              info: 'Permissão',
              controller: roleController,
            ),
            SizedBox(height: 16),
            InfoTextField(
              info: 'Relação com a FATEC',
              controller: relationshipController,
            ),
          ],
        ),
      ),
    );
  }
}
