import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';

class SignOutIconButton extends StatelessWidget {
  SignOutIconButton({super.key});

  final Logger logger = Logger();

  @override
  Widget build(BuildContext context) {
    // final mainProvider = context.watch<MainProvider>();
    return IconButton(
      icon: Icon(Icons.logout, color: Colors.deepPurple),
      onPressed: () async {
        try {
          // await mainProvider.signOut();
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
