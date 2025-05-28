import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:setec_app/providers/auth_state_notifier.dart';
import 'package:setec_app/ui/home/providers/home_provider.dart';
import 'package:setec_app/ui/home/widgets/sign_in_text_button.dart';

class AppBarWidget extends ConsumerWidget implements PreferredSizeWidget {
  const AppBarWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentIndex = ref.watch(navControllerProvider);
    final title = ref.watch(appBarTitlesProvider);

    return AppBar(
      title: Text(title[currentIndex]),
      actions: <Widget>[
        if (!ref.watch(authProvider).isAuthenticated)
          SignInTextButton(parentContext: context),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(50);
}
