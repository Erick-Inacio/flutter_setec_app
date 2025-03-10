import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:setec_app/utils/functions/checkin_user_status.dart';
import 'package:setec_app/utils/provider/auth_provider_model.dart';
import 'package:setec_app/widgets/drawer/custom_drawer.dart';
import 'package:setec_app/widgets/navBar/bottom_app_bar.dart';

class HomePageNavBar extends StatefulWidget {
  final Widget child;
  const HomePageNavBar({super.key, required this.child});

  @override
  State<HomePageNavBar> createState() => _HomePageState();
}

class _HomePageState extends State<HomePageNavBar> {
  //Gerenciador de Estado
  late AuthProvider authProvider;
  // UserApp userApp = UserApp.empty();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    authProvider = context.watch<AuthProvider>();
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
      ),
      drawer: authProvider.isAuthenticated
          ? CustomDrawer(
              parentContext: context,
            )
          : null,
      bottomNavigationBar:
          authProvider.isAuthenticated ? CustomBottomAppBar() : null,
      floatingActionButton: _isVisible(currentRoute),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndDocked,
      body: widget.child,
    );
  }
}

_isVisible(String route) {
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
      onPressed: () {},
      backgroundColor: Colors.deepPurple,
      child: Icon(
        Icons.add,
        color: Colors.white,
      ),
    );
  }
}
