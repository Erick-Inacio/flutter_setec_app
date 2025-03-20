import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:setec_app/providers/main_provider.dart';

class SignInIconButton extends StatelessWidget {
  final BuildContext parentContext;
  const SignInIconButton({super.key, required this.parentContext});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.login_rounded, color: Colors.deepPurple),
      onPressed: () async {
        final mainProvider =
            Provider.of<MainProvider>(parentContext, listen: false);
        Logger().i('SignInButtom: $mainProvider.actualUser.toString()');

        if (context.mounted) {
          context.push('/loginOptions');
        }
      },
    );
  }
}
