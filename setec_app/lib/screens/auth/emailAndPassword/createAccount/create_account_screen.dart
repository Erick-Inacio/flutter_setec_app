import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:setec_app/utils/provider/auth_provider_model.dart';
import 'package:setec_app/models/user_app_model.dart';
import 'package:setec_app/utils/enums/relationship.dart';

class CreateAccount extends StatefulWidget {
  const CreateAccount({super.key});

  @override
  State<CreateAccount> createState() => _CreateAccountWithEmailScreenState();
}

class _CreateAccountWithEmailScreenState extends State<CreateAccount> {
  final _formKey = GlobalKey<FormState>();

  //Create account Controllers
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();

  late String _relationship;
  List<String> _relationships = [];
  final Logger logger = Logger();

  @override
  void initState() {
    super.initState();
    // _roles = Roles.rolesName
    //     .where(
    //       (e) =>
    //           e != Roles.admin.displayName && e != Roles.comission.displayName,
    //     )
    //     .toList();
    _relationships = Relationship.rolesName;
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = context.watch<AuthProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Criar Conta"),
      ),
      body: Form(
        key: _formKey,
        child: Center(
          child: ListView(
            shrinkWrap: true,
            padding: const EdgeInsets.all(16.0),
            children: <Widget>[
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      // Nome Completo
                      TextFormField(
                        controller: _nameController,
                        decoration: const InputDecoration(
                          labelText: 'Nome completo',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor, insira um nome válido';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 16.0),
          
                      //Email
                      TextFormField(
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: const InputDecoration(
                          labelText: 'Email',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor, insira um email válido';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 16.0),
          
                      //Senha
                      TextFormField(
                        controller: _passwordController,
                        obscureText: true,
                        decoration: const InputDecoration(
                          labelText: 'Senha',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor, insira uma senha válida';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 16.0),
          
                      // Relationship
                      DropdownButtonFormField(
                        // focusColor: Colors.deepPurple,
                        style: GoogleFonts.lato(
                          fontWeight: FontWeight.normal,
                          color: Colors.deepPurple,
                          fontSize: 16,
                        ),
                        items: _relationships
                            .map((relationship) => DropdownMenuItem(
                                  value: relationship,
                                  child: Text(relationship),
                                ))
                            .toList(),
                        onChanged: (value) {
                          _relationship = value.toString();
                        },
                        decoration: const InputDecoration(
                            labelText: 'Relação com a FATEC'),
                      ),
                      SizedBox(height: 16.0),
                    ],
                  ),
                ),
              ),
          
              //Botão
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 16, 0, 40),
                child: ElevatedButton(
                  onPressed: () async {
                    _buttomFunction(context, authProvider);
                  },
                  child: Text(
                    'Próximo',
                    style: GoogleFonts.lato(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _buttomFunction(
    BuildContext context,
    AuthProvider authProvider,
  ) async {
    if (_formKey.currentState!.validate()) {
      try {
        UserApp userApp = UserApp.empty();

        userApp.email = _emailController.text;
        userApp.name = _nameController.text;

        if (context.mounted) {
          userApp.relationship =
              Relationship.fromNameEnum(_relationship) as Relationship;
          context.push(
            '/createUser',
            extra: {
              "user": userApp,
              "password": _passwordController.text,
            },
          );
        }
      } on Exception catch (e) {
        logger.e('CreateAccount : $e');
      }
    }
  }
}
