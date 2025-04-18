import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:setec_app/providers/auth_state_notifier.dart';
import 'package:setec_app/ui/home/providers/home_provider.dart';

class FloatingButtomWidget extends ConsumerWidget {
  const FloatingButtomWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentIndex = ref.watch(navControllerProvider);
    return _hasPermission(ref)
        ? FloatingActionButton(
            backgroundColor: Colors.deepPurpleAccent,
            child: const Icon(Icons.add_rounded, color: Colors.white),
            onPressed: () async {
              if (currentIndex == 2 && _hasPermission(ref)) {
                context.push('/createEvent');
              }
              
            },
          )
        : Container();
  }

  bool _hasPermission(WidgetRef ref) {
    final authState = ref.watch(authProvider);
    final index = ref.watch(navControllerProvider);

    if (!authState.isAuthenticated) return false;

    if (index == 0 || index == 1) {
      return (authState.isAdmin || authState.isSpeaker);
    }

    if (index == 2) {
      return authState.isAdmin;
    }

    return false;
  }
}
