import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:setec_app/providers/main_provider.dart';

class SignOutIconButton extends StatelessWidget {
  const SignOutIconButton({super.key});

  @override
  Widget build(BuildContext context) {
    final mainProvider = context.watch<MainProvider>();
    return IconButton(
      icon: Icon(Icons.logout, color: Colors.deepPurple),
      onPressed: () async {
        try {
          await mainProvider.signOut();
          Logger().i(
              "SignOutButtom: Rebuild da tela. Usuário atual: ${mainProvider.actualUser}");
          Logger().i('SignOutButtom: ${mainProvider.actualUser.toString()}');

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
