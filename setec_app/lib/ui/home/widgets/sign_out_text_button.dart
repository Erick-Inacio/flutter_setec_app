import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:logger/logger.dart';
import 'package:setec_app/providers/auth_state_notifier.dart';

class SignOutTextButton extends ConsumerWidget {
  SignOutTextButton({super.key});

  final Logger logger = Logger();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final auth = ref.read(authProvider.notifier);
    final authState = ref.read(authProvider);
    return TextButton(
      onPressed: () async {
        try {
          await auth.logout(authState.user!);

          if (context.mounted) {
            context.go('/home/lectures');
          }
        } catch (e) {
          throw Exception("Failed to sign out: $e");
        }
      },
      child: const Text("Sair"),
    );
  }
}
