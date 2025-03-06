import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:setec_app/utils/provider/auth_provider_model.dart';
import 'package:setec_app/models/speaker_model.dart';
import 'package:setec_app/models/user_app_model.dart';
import 'package:setec_app/utils/enums/roles.dart';

class BottomNavBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onTabTapped;

  const BottomNavBar({
    super.key,
    required this.onTabTapped,
    required this.selectedIndex,
  });

  @override
  Widget build(BuildContext context) {
    final authProvider = context.read<AuthProvider>();

    bool isAdmin = false;

    UserApp userApp = UserApp.empty();
    if (authProvider.actualUser != null) {
      userApp = authProvider.actualUser! is Speaker
          ? authProvider.actualUser!.user
          : authProvider.actualUser!;

      isAdmin = userApp.role == Roles.admin;
    }

    return BottomNavigationBar(
      selectedItemColor: Colors.deepPurple,
      backgroundColor: Colors.deepPurple.shade50,
      currentIndex: selectedIndex,
      onTap: (index) {
        onTabTapped(index);
        if (authProvider.isAuthenticated) {
          switch (index) {
            case 0:
              context.go('/home');
              break;
            case 1:
              context.go('/events');
              break;
            case 2:
              context.go('/user', extra: {'context': context});
              break;
          }
        }
      },
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.emoji_food_beverage_rounded),
          label: 'Eventos',
          backgroundColor: Colors.deepPurple,
        ),
        BottomNavigationBarItem(
          icon: isAdmin ? Icon(Icons.admin_panel_settings) : Icon(Icons.person),
          label: isAdmin ? 'Admin' : 'Perfil',
          backgroundColor: Colors.deepPurple,
        ),
      ],
    );
  }
}
