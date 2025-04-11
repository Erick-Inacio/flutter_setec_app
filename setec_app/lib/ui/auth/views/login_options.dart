import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sign_in_button/sign_in_button.dart';

class LoginOptions extends ConsumerWidget {
  const LoginOptions({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final authState = ref.watch(authAsyncProvider); // escuta estado (opcional agora)
    // final authVM = ref.read(authAsyncProvider.notifier); // viewmodel (se quiser usar depois)

    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SignInButton(
                Buttons.google,
                text: "Entre com o Google",
                onPressed: () {
                  // Aqui você pode futuramente chamar:
                  // authVM.loginWithGoogle(context);
                },
              ),
              Material(
                color: Colors.transparent,
                child: GestureDetector(
                  onTap: () {
                    context.push('/loginWithEmail');
                  },
                  child: SizedBox(
                    width: 228,
                    height: 45,
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(2.0),
                      ),
                      color: Colors.white,
                      elevation: 2,
                      child: Row(children: [
                        const Padding(
                          padding: EdgeInsets.fromLTRB(5, 0, 38, 0),
                          child: Icon(
                            Icons.email,
                            color: Colors.deepPurple,
                          ),
                        ),
                        const Text(
                          "Email e Senha",
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                          ),
                        )
                      ]),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
