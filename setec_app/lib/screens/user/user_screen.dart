import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:setec_app/providers/auth_provider_model.dart';
import 'package:setec_app/models/speaker_model.dart';
import 'package:setec_app/models/user_app_model.dart';
import 'package:setec_app/utils/enums/relationship.dart';
import 'package:setec_app/widgets/Text/FormField/speaker_form_field.dart';

class UserScreen extends StatefulWidget {
  final BuildContext? parentContext;
  final dynamic user;

  const UserScreen({super.key, this.user, this.parentContext});
  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController raController = TextEditingController();
  late TextEditingController emailController = TextEditingController();
  late TextEditingController roleController = TextEditingController();
  late TextEditingController relationshipController = TextEditingController();

  //Speaker fields
  late TextEditingController bioController = TextEditingController();
  late TextEditingController companyController = TextEditingController();
  late TextEditingController positionController = TextEditingController();

  UserApp userApp = UserApp.empty();

  late dynamic _user;
  late bool isStudent;
  late bool isSpeaker;

  @override
  void initState() {
    _initValues();
    super.initState();
  }

  @override
  void dispose() {
    raController.dispose();
    emailController.dispose();
    roleController.dispose();
    relationshipController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Form(
        key: _formKey,
        child: ListView(
          shrinkWrap: true,
          padding: const EdgeInsets.all(16.0),
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
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
                    SizedBox(height: 16),
                    TextFormField(
                      enabled: false,
                      decoration: InputDecoration(labelText: 'Email'),
                      controller: emailController,
                    ),
                    SizedBox(height: 16),
                    TextFormField(
                      enabled: false,
                      decoration: InputDecoration(
                        labelText: 'Permissão',
                      ),
                      controller: roleController,
                    ),
                    SizedBox(height: 16),
                    TextFormField(
                      enabled: false,
                      decoration:
                          InputDecoration(labelText: 'Relação com a FATEC'),
                      controller: relationshipController,
                    ),
                    SizedBox(height: 16),
                    isStudent
                        ? TextFormField(
                            enabled: false,
                            decoration: InputDecoration(labelText: 'RA'),
                            controller: raController,
                          )
                        : Container(),
                  ],
                ),
              ),
            ),
            isSpeaker
                ? FormSpeakerField(
                    parentContext: context,
                    company: companyController,
                    position: positionController,
                    bio: bioController,
                  )
                : Container(),
          ],
        ),
      ),
    );
  }

  void _initValues() {
    _user = widget.user ?? widget.parentContext!.watch<AuthProvider>();

    if (widget.user == null) {
      if (_user.actualUser is Speaker) {
        isSpeaker = true;

        bioController.text = _user.actualUser!.bio as String;
        companyController.text = _user.actualUser!.company as String;
        positionController.text = _user.actualUser!.position as String;

        userApp = _user.actualUser!.user;
      } else {
        isSpeaker = false;

        userApp = _user.actualUser!;
      }
    } else if (widget.user is! Speaker) {
      isSpeaker = false;
      userApp = widget.user;
    }
    isStudent = userApp.relationship == Relationship.aluno ? true : false;
    raController.text = isStudent ? userApp.ra as String : '';
    emailController.text = userApp.email;
    roleController.text = userApp.role.displayName;
    relationshipController.text = userApp.relationship.displayName;
  }
}
