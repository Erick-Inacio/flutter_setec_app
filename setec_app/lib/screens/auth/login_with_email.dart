import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:setec_app/models/auth_provider_model.dart';
import 'package:setec_app/models/speaker_model.dart';
import 'package:setec_app/models/user_app_model.dart';
import 'package:setec_app/services/backend/speaker_service.dart';
import 'package:setec_app/services/firebase/auth/auth_service.dart';
import 'package:setec_app/utils/enums/roles.dart';

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

  @override
  Widget build(BuildContext context) {
    final authProvider = context.watch<AuthProvider>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
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
                  controller: _emailController,
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
      UserApp? userApp;

      try {
        userApp = await _authService.login(
          _emailController.text,
          _passwordController.text,
        );
        authProvider.setUserApp(userApp);
      } catch (e) {
        authProvider.signOut();
        logger.e('LoginWithEmail: $e');
      }

      if (userApp != null && userApp.role == Roles.speaker && context.mounted) {
        Speaker? speaker;
        try {
          speaker = await SpeakerService.getSpeakerByUserId(userApp.id as int);
        } on Exception catch (e) {
          authProvider.signOut();
          logger.e('LoginWithEmail: $e');
        }
        if (speaker != null && context.mounted) {
          authProvider.turningIntoASpeaker(speaker.socialMedia, speaker.company,
              speaker.position, speaker.bio);

          context.go('/home');
        }
      }
      if (userApp != null && context.mounted) {
        logger.i('LoginWithEmail: ${authProvider.userApp.toString()}');
        context.go('/home');
      }
    }
  }
}
