import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:setec_app/utils/provider/auth_provider_model.dart';
import 'package:setec_app/models/speaker_model.dart';
import 'package:setec_app/models/user_app_model.dart';
import 'package:setec_app/services/backend/speaker_services.dart';
import 'package:setec_app/services/firebase/auth/auth_service.dart';
import 'package:setec_app/utils/enums/roles.dart';
import 'package:setec_app/widgets/snackBar/exception_snack_bar.dart';

class LoginWithEmail extends StatefulWidget {
  const LoginWithEmail({super.key});

  @override
  State<LoginWithEmail> createState() => _LoginWithEmailState();
}

class _LoginWithEmailState extends State<LoginWithEmail> {
  Logger logger = Logger();

  final _formKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final AuthService _authService = AuthService();

  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    final authProvider = context.watch<AuthProvider>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
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
                      SizedBox(height: 10),
                      TextFormField(
                        controller: _passwordController,
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: true,
                        decoration: const InputDecoration(
                          labelText: 'Password',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor, insira uma senha válida';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: <Widget>[
                          TextButton(
                            onPressed: () {
                              context.push('/criarConta');
                            },
                            child: const Text(
                              'Criar Conta',
                              style: TextStyle(
                                color: Colors.deepPurple,
                                fontSize: 12.0,
                              ),
                            ),
                          ),
                          const Spacer(),
                          TextButton(
                            onPressed: () {},
                            child: const Text(
                              'Esqueci minha senha',
                              style: TextStyle(
                                color: Colors.deepPurple,
                                fontSize: 12.0,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.deepPurple,
                          minimumSize: Size(double.infinity, 45),
                        ),
                        onPressed: () async {
                          _navigationTo(context, authProvider);
                        },
                        child: Text(
                          'Login',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }

  void _navigationTo(BuildContext context, AuthProvider authProvider) async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });
      UserApp? userApp;

      try {
        userApp = await _authService.login(
          _emailController.text,
          _passwordController.text,
        );

        if (userApp != null) {
          authProvider.setUserApp(userApp);
        }
      } catch (e) {
        authProvider.signOut();
        setState(() {
          _isLoading = false;
        });
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            ExceptionSnackBar(
              message: e.toString(),
            ),
          );
        }
        logger.e('LoginWithEmail: $e');
      }

      //TODO: tentar otimizar a consulta no banco para ver se o usuário é speaker e já retornar tudo em uma unica consulta
      if (userApp != null && userApp.role == Roles.speaker && context.mounted) {
        Speaker? speaker;
        try {
          SpeakerServices speakerServices = SpeakerServices();
          speaker = await speakerServices.getByUser(userApp.id as int);
        } on Exception catch (e) {
          authProvider.signOut();
          setState(() {
            _isLoading = false;
          });
          logger.e('LoginWithEmail: $e');
        }
        if (speaker != null && context.mounted) {
          authProvider.setSpeaker(speaker);
          setState(() {
            _isLoading = false;
          });
          context.go('/home');
        }
      }
      if (userApp != null && context.mounted) {
        logger.i('LoginWithEmail: ${authProvider.actualUser.toString()}');
        setState(() {
          _isLoading = false;
        });
        context.go('/home');
      }
    }
  }
}
