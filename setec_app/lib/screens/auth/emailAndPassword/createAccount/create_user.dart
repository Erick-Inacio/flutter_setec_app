import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:setec_app/models/auth_provider_model.dart' as auth;
import 'package:setec_app/models/speaker_model.dart';
import 'package:setec_app/models/user_app_model.dart';
import 'package:setec_app/services/backend/speaker_service.dart';
import 'package:setec_app/services/backend/user_service.dart';
import 'package:setec_app/services/firebase/auth/auth_service.dart';
import 'package:setec_app/utils/enums/relationship.dart';
import 'package:setec_app/utils/enums/roles.dart';
import 'package:setec_app/widgets/Text/FormField/speaker_form_field.dart';
import 'package:setec_app/widgets/buttom/custom_buttom.dart';

class CreateUser extends StatefulWidget {
  final UserApp userApp;
  final String password;

  const CreateUser({
    super.key,
    required this.userApp,
    required this.password,
  });

  @override
  State<CreateUser> createState() => _CreateUserState();
}

class _CreateUserState extends State<CreateUser> {
  final _formKey = GlobalKey<FormState>();

  //speaker controllers
  final TextEditingController _companyController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  final TextEditingController _positionController = TextEditingController();
  final TextEditingController _ra = TextEditingController();

  late Roles _role = Roles.student;

  bool _isLoading = false;

  bool isSpeaker = false;

  @override
  void dispose() {
    _companyController.dispose();
    _bioController.dispose();
    _positionController.dispose();
    _ra.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Criar Usuário"),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Form(
              key: _formKey,
              child: Center(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: <Widget>[
                      Card(
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              // Ra se aluno
                              widget.userApp.relationship == Relationship.aluno
                                  ? TextFormField(
                                      controller: _ra,
                                      keyboardType: TextInputType.number,
                                      maxLength: 13,
                                      decoration: const InputDecoration(
                                        labelText: 'RA',
                                      ),
                                      style: GoogleFonts.lato(
                                        color: Colors.deepPurple,
                                        fontSize: 15,
                                      ),
                                    )
                                  : Container(),
                              //Role
                              Container(
                                height: 56,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(4.0),
                                  border: Border.all(
                                    color: Colors.deepPurple,
                                    width: 1.0,
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      Text(
                                        'Irá palestrar?',
                                        style: GoogleFonts.lato(
                                          color: Colors.deepPurple,
                                          fontSize: 20,
                                        ),
                                      ),
                                      Spacer(),
                                      Switch(
                                        inactiveThumbColor: Colors.deepPurple,
                                        activeColor: Colors.deepPurple,
                                        inactiveTrackColor:
                                            Colors.deepPurple.shade50,
                                        value: isSpeaker,
                                        onChanged: (bool value) {
                                          setState(() {
                                            isSpeaker = value;
                                          });
                                          if (value) {
                                            _role = Roles.speaker;
                                          }
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      isSpeaker
                          ? FormSpeakerField(
                              company: _companyController,
                              position: _positionController,
                              bio: _bioController,
                              parentContext: context,
                            )
                          : Container(),
                      CustomButtom(
                        text: "Salvar",
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            setState(() {
                              _isLoading = true;
                            });
                            widget.userApp.role = _role;
                            widget.userApp.ra = _ra.text;

                            if (isSpeaker) {
                              Speaker speaker = Speaker(
                                company: _companyController.text,
                                position: _positionController.text,
                                bio: _bioController.text,
                                user: widget.userApp,
                                socialMedia: {},
                              );
                              await _buttomFunction(
                                context: context,
                                speaker: speaker,
                              );
                            } else {
                              await _buttomFunction(
                                context: context,
                              );
                            }
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }

  Future<void> _buttomFunction({
    required BuildContext context,
    Speaker? speaker,
  }) async {
    bool createdUser = true;

    if (context.mounted) {
      try {
        final authService = AuthService();
        final authProvider =
            Provider.of<auth.AuthProvider>(context, listen: false);

        //tenta criar conta no firebase
        UserApp? authenticatedUserApp = await authService.registerWithEmail(
          widget.userApp.email,
          widget.password,
        );

        //se não conseguiu, lança uma exceção
        if (authenticatedUserApp == null) {
          createdUser = false;
          throw Exception(
            "Failed to create user in firebase: ${authenticatedUserApp.toString()}",
          );
        }

        //se conseguiu, completa o usuário autenticado com os dados do usuário original
        authenticatedUserApp.name = widget.userApp.name;
        authenticatedUserApp.relationship = widget.userApp.relationship;
        authenticatedUserApp.role = _role;

        if (authenticatedUserApp.relationship == Relationship.aluno) {
          authenticatedUserApp.ra = _ra.text;
        } else {
          authenticatedUserApp.ra = null;
        }

        //se conseguiu, tenta criar o usuário no banco
        final savedUserApp =
            await UserServices.createUser(authenticatedUserApp);

        //se não conseguiu, lança uma exceção
        if (savedUserApp == null) {
          createdUser = false;
          throw Exception(
              "Failed to save user in database: ${savedUserApp.toString()}");
        }
        //se for um speaker, tenta criar o palestrante no banco
        if (isSpeaker && speaker != null) {
          speaker.user = savedUserApp;
          final savedSpeaker = await SpeakerServices.createSpeaker(speaker);

          //se não conseguiu, lança uma exceção
          if (savedSpeaker == null) {
            createdUser = false;
            throw Exception(
              "Failed to save speaker in database: ${savedSpeaker.toString()}",
            );
          }

          //se conseguiu, define o usuário como palestrante
          //e salva as informações no provider
          authProvider.setUserApp(savedUserApp);
          authProvider.setSpeaker(savedSpeaker);

          if (authProvider.actualUser != null && context.mounted) {
            context.go('/home');
          } else {
            authProvider.signOut();
            setState(() {
              _isLoading = false;
            });
            throw Exception("Failed to get user from provider");
          }
        } else {
          //se não for um palestrante, salva as informações no provider
          //como usuario comum
          authProvider.setUserApp(savedUserApp);

          if (authProvider.actualUser != null && context.mounted) {
            context.go('/home');
          }
        }
      } on Exception catch (e, stackTrace) {
        if (!createdUser) {
          AuthService authServices = AuthService();
          final user = FirebaseAuth.instance.currentUser;
          if (user != null) {
            await authServices.deleteUser();
            Logger().e("user excluded: $e, $stackTrace");
          } else {
            Logger().e("Failed to exclude user: $e, $stackTrace");
          }
        }
        Logger().e("Failed to create user: $e, $stackTrace");
      }
    }
  }
}
