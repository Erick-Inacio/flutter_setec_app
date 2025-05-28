import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:setec_app/ui/auth/viewModel/auth_view_model.dart';
import 'package:setec_app/ui/auth/widgets/mock_users.dart';

class LoginWithEmail extends ConsumerStatefulWidget {
  const LoginWithEmail({super.key});

  @override
  ConsumerState<LoginWithEmail> createState() => _LoginWithEmailState();
}

class _LoginWithEmailState extends ConsumerState<LoginWithEmail> {
  final _formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authAsyncProvider);
    final authVM = ref.read(authAsyncProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Center(
            child: ListView(
              shrinkWrap: true,
              padding: const EdgeInsets.all(16.0),
              children: <Widget>[
                TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(labelText: 'Email'),
                  validator: (value) => authVM.validateEmail(value),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _passwordController,
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: true,
                  decoration: const InputDecoration(labelText: 'Senha'),
                  validator: (value) => authVM.validatePassword(value),
                ),
                const SizedBox(height: 10),
                Row(
                  children: <Widget>[
                    TextButton(
                      onPressed: () => context.push('/createAccount'),
                      child: const Text(
                        'Criar Conta',
                        style:
                            TextStyle(color: Colors.deepPurple, fontSize: 12),
                      ),
                    ),
                    const Spacer(),
                    TextButton(
                      onPressed: () {},
                      child: const Text(
                        'Esqueci minha senha',
                        style:
                            TextStyle(color: Colors.deepPurple, fontSize: 12),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 40),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple,
                    minimumSize: const Size(double.infinity, 50),
                  ),
                  onPressed: authState is AsyncLoading
                      ? null 
                      : () async {
                          if (_formKey.currentState!.validate()) {
                            await authVM.login(
                              formKey: _formKey,
                              email: _emailController.text,
                              password: _passwordController.text,
                              context: context,
                            );
                          }
                        },

                  child: authState is AsyncLoading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text(
                          'Login',
                          style: TextStyle(color: Colors.white),
                        ),
                ),
                const SizedBox(height: 40),
                MockUsers(
                  emailController: _emailController,
                  passwordController: _passwordController,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
