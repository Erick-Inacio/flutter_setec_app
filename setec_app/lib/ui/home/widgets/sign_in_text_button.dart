import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SignInTextButton extends StatelessWidget {
  final BuildContext parentContext;
  const SignInTextButton({super.key, required this.parentContext});

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: () async {
          if (parentContext.mounted && context.mounted) {
            context.push('/login');
          }
        },
        child: Text(
          "Entrar",
          style: TextStyle(
            color: Colors.deepPurple,
          ),
        ));
  }
}
