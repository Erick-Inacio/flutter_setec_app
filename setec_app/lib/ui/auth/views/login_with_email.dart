import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:setec_app/data/speaker/service/speaker_services.dart';
import 'package:setec_app/domain/models/speaker.dart';
import 'package:setec_app/domain/models/user_app.dart';
import 'package:setec_app/providers/session_provider.dart';
import 'package:setec_app/data/firebase/auth/auth_repository.dart';
import 'package:setec_app/core/enums/roles.dart';
import 'package:setec_app/ui/core/ui/widgets/buttom/mock_users.dart';
import 'package:setec_app/ui/core/ui/widgets/snackBar/exception_snack_bar.dart';

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

  final AuthService _AuthService = AuthService();

  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    // final mainProvider = context.watch<MainProvider>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Form(
              key: _formKey,
              child: Center(
                child: ListView(
                  shrinkWrap: true,
                  padding: const EdgeInsets.all(16.0),
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
                        // _navigationTo(context, mainProvider);
                      },
                      child: Text(
                        'Login',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    MockUsers(
                      emailController: _emailController,
                      passwordController: _passwordController,
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  // void _navigationTo(BuildContext context, MainProvider mainProvider) async {
  //   if (_formKey.currentState!.validate()) {
  //     setState(() {
  //       _isLoading = true;
  //     });
  //     UserApp? userApp;

  //     try {
  //       userApp = await _AuthService.login(
  //         _emailController.text,
  //         _passwordController.text,
  //       );

  //       if (userApp != null && context.mounted) {
  //         mainProvider.setUserApp(context, userApp);
  //       }
  //     } catch (e) {
  //       mainProvider.signOut();
  //       setState(() {
  //         _isLoading = false;
  //       });
  //       if (context.mounted) {
  //         ScaffoldMessenger.of(context).showSnackBar(
  //           ExceptionSnackBar(
  //             message: e.toString(),
  //           ),
  //         );
  //       }
  //       logger.e('LoginWithEmail: $e');
  //     }

  //     if (userApp != null && userApp.role == Roles.speaker && context.mounted) {
  //       Speaker? speaker;
  //       try {
  //         SpeakerServices speakerServices = SpeakerServices();
  //         // speaker = await speakerServices.getByUser(userApp.id as int);
  //       } on Exception catch (e) {
  //         mainProvider.signOut();
  //         setState(() {
  //           _isLoading = false;
  //         });
  //         logger.e('LoginWithEmail: $e');
  //       }
  //       if (speaker != null && context.mounted) {
  //         mainProvider.setSpeaker(context, speaker);
  //         setState(() {
  //           _isLoading = false;
  //         });
  //         context.go('/lectures');
  //       }
  //     }
  //     if (userApp != null && context.mounted) {
  //       logger.i('LoginWithEmail: ${mainProvider.actualUser.toString()}');
  //       setState(() {
  //         _isLoading = false;
  //       });
  //       context.go('/lectures');
  //     }
  //   }
  // }
}
