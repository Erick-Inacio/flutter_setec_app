import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:setec_app/utils/provider/auth_provider_model.dart';

class SignOutIconButton extends StatelessWidget {
  final BuildContext parentContext;
  const SignOutIconButton({super.key, required this.parentContext});

  @override
  Widget build(BuildContext context) {
    final authProvider = context.watch<AuthProvider>();
    return IconButton(
      icon: Icon(Icons.logout, color: Colors.deepPurple),
      onPressed: () async {
        try {
          await authProvider.signOut();
          Logger().i(
              "SignOutButtom: Rebuild da tela. Usuário atual: ${authProvider.actualUser}");
          Logger().i('SignOutButtom: $authProvider.actualUser.toString()');

          if (context.mounted) {
            context.go('/loginOptions');
          }
        } catch (e) {
          throw Exception("Failed to sign out: $e");
        }
      },
    );
  }
}
