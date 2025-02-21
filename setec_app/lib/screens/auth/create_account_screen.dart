import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:setec_app/models/auth_provider_model.dart';
import 'package:setec_app/models/user_app_model.dart';
import 'package:setec_app/services/backend/user_service.dart';
import 'package:setec_app/services/firebase/auth/auth_service.dart';
import 'package:setec_app/utils/enums/relationship.dart';
import 'package:setec_app/utils/enums/roles.dart';

class CreateAccount extends StatefulWidget {
  const CreateAccount({super.key});

  @override
  State<CreateAccount> createState() => _CreateAccountWithEmailScreenState();
}

class _CreateAccountWithEmailScreenState extends State<CreateAccount> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ra = TextEditingController();
  late String _role;
  List<String> _roles = [];
  late String _relationship;
  List<String> _relationships = [];
  final Logger logger = Logger();

  @override
  void initState() {
    super.initState();
    _roles = Roles.rolesName
        .where(
          (e) =>
              e != Roles.admin.displayName && e != Roles.comission.displayName,
        )
        .toList();
    _relationships = Relationship.rolesName;
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
    _ra.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = context.watch<AuthProvider>();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Criar Conta"),
      ),
      body: Center(
          child: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Nome',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira um nome válido';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
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
              TextFormField(
                controller: _ra,
                decoration: const InputDecoration(
                  labelText: 'RA',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira um RA válido';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
              DropdownButtonFormField(
                style: const TextStyle(
                  fontWeight: FontWeight.normal,
                  color: Colors.deepPurple,
                ),
                items: _roles
                    .map((role) => DropdownMenuItem(
                          value: role,
                          child: Text(role),
                        ))
                    .toList(),
                onChanged: (value) {
                  _role = value.toString();
                },
                decoration:
                    const InputDecoration(labelText: 'Tipo de Cadastro'),
              ),
              SizedBox(height: 16.0),
              DropdownButtonFormField(
                focusColor: Colors.deepPurple,
                style: const TextStyle(
                    fontWeight: FontWeight.normal, color: Colors.deepPurple),
                items: _relationships
                    .map((relationship) => DropdownMenuItem(
                          value: relationship,
                          child: Text(relationship),
                        ))
                    .toList(),
                onChanged: (value) {
                  _relationship = value.toString();
                },
                decoration:
                    const InputDecoration(labelText: 'Relação com a FATEC'),
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                onPressed: () async {                    
                  if (_formKey.currentState!.validate()) {

                    try {
                      AuthService authService = AuthService();
                      UserApp? userApp = await authService.registerWithEmail(
                          _emailController.text, _passwordController.text);

                      if (userApp != null) {
                        userApp.name = _nameController.text;
                        userApp.role = Roles.fromNameEnum(_role) as Roles;
                        userApp.relationship =
                            Relationship.fromNameEnum(_relationship)
                                as Relationship;
                        userApp.ra = _ra.text;
                        try {
                          userApp = await UserServices.createUser(userApp);
                          authProvider.setUserApp(userApp);

                          if (context.mounted) {
                            context.go('/home');
                          }
                        } on Exception catch (e) {
                          authProvider.signOut();
                          logger.e('CreateAccount : $e');
                        }
                      }
                    } on Exception catch (e) {
                      authProvider.signOut();
                      logger.e('CreateAccount : $e');
                    }
                  }
                },
                child: const Text(
                  'Criar Conta',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      )),
    );
  }
}
