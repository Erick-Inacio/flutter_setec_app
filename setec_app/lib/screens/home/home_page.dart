import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:setec_app/models/auth_provider_model.dart';
import 'package:setec_app/models/speaker_model.dart';
import 'package:setec_app/models/user_app_model.dart';
import 'package:setec_app/utils/enums/roles.dart';
import 'package:setec_app/widgets/iconButton/sign_in_icon_button.dart';
import 'package:setec_app/widgets/iconButton/sign_out_icon_button.dart';
import 'package:setec_app/widgets/navBar/bottom_nav_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //Gerenciador de Estado
  late AuthProvider authProvider;

  CarouselController carouselController = CarouselController(
    initialItem: 1,
  );

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    authProvider = context.watch<AuthProvider>();

    return Scaffold(
      bottomNavigationBar: authProvider.isAuthenticated
          ? BottomNavBar(
              currentIndex: 0,
            )
          : null,
      appBar: AppBar(
        title: const Text("Home Page"),
        actions: typeButtom(authProvider),
      ),
      body: Column(
        children: <Widget>[
          // SizedBox(
          //   height: 200,
          //   child: CarouselView(
          //     controller: carouselController,
          //     itemExtent: 200.0,
          //     elevation: 4,
          //     children: [
          //       Card(
          //         color: Colors.deepPurple,
          //       ),
          //       Card(
          //         color: Colors.deepPurple,
          //       ),
          //       Card(
          //         color: Colors.deepPurple,
          //       ),
          //       Card(
          //         color: Colors.deepPurple,
          //       ),
          //     ],
          //   ),
          // )
        ],
      ),
    );
  }

  List<Widget> typeButtom(AuthProvider authProvider) {
    UserApp userApp = UserApp.empty();
    if (authProvider.actualUser != null) {
      userApp = authProvider.actualUser! is Speaker
          ? authProvider.actualUser!.user
          : authProvider.actualUser!;
    }

    List<Widget> buttons = [];
    if (authProvider.actualUser != null) {
      if (userApp.role == Roles.admin) {
        buttons.add(
          IconButton(
            icon: Icon(Icons.admin_panel_settings),
            onPressed: () {
              context.push('/adminUser');
            },
          ),
        );
      }
      buttons.add(
        SignOutIconButton(
          parentContext: context,
        ),
      );
    } else {
      buttons.add(
        SignInIconButton(
          parentContext: context,
        ),
      );
    }

    return buttons;
  }
}
