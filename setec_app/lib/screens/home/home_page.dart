import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:setec_app/utils/functions/checkin_user_status.dart';
import 'package:setec_app/providers/main_provider.dart';
import 'package:setec_app/widgets/drawer/custom_drawer.dart';
import 'package:setec_app/widgets/iconButton/sign_out_icon_button.dart';
import 'package:setec_app/widgets/navBar/bottom_app_bar.dart';

class HomePageNavBar extends StatefulWidget {
  final Widget child;
  const HomePageNavBar({super.key, required this.child});

  @override
  State<HomePageNavBar> createState() => _HomePageState();
}

class _HomePageState extends State<HomePageNavBar> {
  //Gerenciador de Estado
  late MainProvider mainProvider;
  // UserApp userApp = UserApp.empty();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    mainProvider = context.watch<MainProvider>();
    String currentRoute = GoRouterState.of(context).uri.toString();

    String title = '';

    if (currentRoute == '/lectures') {
      title = 'Agenda de Palestras';
    } else if (currentRoute == '/miniCourses') {
      title = 'Mini Cursos';
    } else if (currentRoute == '/events') {
      title = 'Eventos';
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        actions: <Widget>[
          mainProvider.actualUser == null
              ? SignOutIconButton()
              : Container(),
        ]
      ),
      drawer: mainProvider.isAuthenticated
          ? CustomDrawer(
              parentContext: context,
            )
          : null,
      bottomNavigationBar:
          mainProvider.isAuthenticated ? CustomBottomAppBar() : null,
      floatingActionButton: _isVisible(currentRoute, context),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndDocked,
      body: widget.child,
    );
  }
}

_isVisible(String route, BuildContext context) {
  final user = CheckingUserStatus();

  if ((route == '/lectures' || route == '/miniCourses') &&
      (user.isSpeaker() || user.isAdmin())) {
    return FloatingActionButton(
      shape: const CircleBorder(),
      onPressed: () {},
      backgroundColor: Colors.deepPurple,
      child: Icon(
        Icons.add,
        color: Colors.white,
      ),
    );
  } else if (route == '/events' && user.isAdmin()) {
    return FloatingActionButton(
      shape: const CircleBorder(),
      onPressed: () {
        context.push('/createEvent');
      },
      backgroundColor: Colors.deepPurple,
      child: Icon(
        Icons.add,
        color: Colors.white,
      ),
    );
  }
}
