import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:setec_app/models/speaker_model.dart';
import 'package:setec_app/models/user_app_model.dart';
import 'package:setec_app/utils/provider/auth_provider_model.dart';
import 'package:setec_app/widgets/drawer/custom_drawer.dart';
import 'package:setec_app/widgets/iconButton/sign_in_icon_button.dart';
import 'package:setec_app/widgets/iconButton/sign_out_icon_button.dart';
import 'package:setec_app/widgets/navBar/bottom_nav_bar.dart';

class HomePageNavBar extends StatefulWidget {
  final Widget child;
  const HomePageNavBar({super.key, required this.child});

  @override
  State<HomePageNavBar> createState() => _HomePageState();
}

class _HomePageState extends State<HomePageNavBar> {
  //Gerenciador de Estado
  late AuthProvider authProvider;

  UserApp userApp = UserApp.empty();
  String name = '';

  //Controlador de index das páginas
  int _selectedIndex = 0;

  //Lista de títulos correspondente às teças
  List<String> _titles = [];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    authProvider = context.watch<AuthProvider>();
    _titles = ['Inicio', 'Eventos', name];

    return Scaffold(
      drawer: authProvider.isAuthenticated
          ? CustomDrawer(
              userApp: userApp,
              parentContext: context,
            )
          : null,
      bottomNavigationBar: authProvider.isAuthenticated
          ? BottomNavBar(
              onTabTapped: _onItemTapped,
              selectedIndex: _selectedIndex,
            )
          : null,
      appBar: AppBar(
        title: Text(_titles[_selectedIndex]),
        actions: <Widget>[
          _typeButtom(authProvider),
        ],
      ),
      body: widget.child,
    );
  }

  Widget _typeButtom(AuthProvider authProvider) {
    if (authProvider.actualUser != null) {
      userApp = authProvider.isSpeaker
          ? authProvider.actualUser!.user
          : authProvider.actualUser!;

      name = userApp.name;
    }

    Widget widget;
    if (authProvider.actualUser != null) {
      widget = SignOutIconButton(
        parentContext: context,
      );
    } else {
      widget = SignInIconButton(
        parentContext: context,
      );
    }

    return widget;
  }
}
