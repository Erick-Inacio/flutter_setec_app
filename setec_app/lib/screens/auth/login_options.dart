import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sign_in_button/sign_in_button.dart';

class LoginOptions extends StatelessWidget {
  const LoginOptions({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.black,
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
                onPressed: () {},
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
                        Padding(
                          padding: const EdgeInsets.fromLTRB(5, 0, 38, 0),
                          child: Icon(
                            Icons.email,
                            color: Colors.deepPurple,
                          ),
                        ),
                        Text(
                          "Email e Senha",
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.w600),
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
