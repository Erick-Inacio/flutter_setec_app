import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:setec_app/models/auth_provider_model.dart';

class SignInIconButton extends StatelessWidget {
  final BuildContext parentContext;
  const SignInIconButton({super.key, required this.parentContext});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.login_rounded, color: Colors.deepPurple),
      onPressed: () async {
        final authProvider =
            Provider.of<AuthProvider>(parentContext, listen: false);
        Logger().i('SignInButtom: $authProvider.actualUser.toString()');

        if (context.mounted) {
          context.push('/loginOptions');
        }
      },
    );
  }
}
