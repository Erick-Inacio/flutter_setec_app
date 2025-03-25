import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SignInIconButton extends StatelessWidget {
  final BuildContext parentContext;
  const SignInIconButton({super.key, required this.parentContext});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.login_rounded, color: Colors.deepPurple),
      onPressed: () async {
        if (parentContext.mounted && context.mounted) {
          context.push('/loginOptions');
        }
      },
    );
  }
}
