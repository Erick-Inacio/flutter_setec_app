import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:setec_app/models/auth_provider_model.dart';
import 'package:setec_app/utils/enums/roles.dart';
import 'package:setec_app/widgets/iconButton/sign_in_icon_button.dart';
import 'package:setec_app/widgets/iconButton/sign_out_icon_button.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final authProvider = context.watch<AuthProvider>();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home Page"),
        actions: [
          typeButtom(authProvider),

          // authProvider.userApp != null &&
          //         authProvider.userApp!.role == Roles.admin
          //     ? IconButton(
          //         icon: Icon(Icons.admin_panel_settings),
          //         onPressed: () {
          //           context.push('/adminUser');
          //         },
          //       )
          //     : Container(),
          authProvider.userApp != null
              ? SignOutIconButton(
                  parentContext: context,
                )
              : SignInIconButton(
                  parentContext: context,
                )
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[],
        ),
      ),
    );
  }

  Widget typeButtom(AuthProvider authProvider) {
    if (authProvider.userApp != null) {
      if (authProvider.userApp!.role == Roles.admin) {
        return IconButton(
          icon: Icon(Icons.admin_panel_settings),
          onPressed: () {
            context.push('/adminUser');
          },
        );
      } else if (authProvider.userApp!.role == Roles.speaker) {
        return IconButton(
          icon: Icon(Icons.person),
          onPressed: () {
            context.push('/createSpeaker', extra: authProvider.userApp);
          },
        );
      }
    }
    return Container();
  }
}
