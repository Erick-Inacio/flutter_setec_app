import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:setec_app/utils/provider/auth_provider_model.dart';

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

    // bool isAdmin = false;

    // UserApp userApp = UserApp.empty();
    // if (authProvider.actualUser != null) {
    //   userApp = authProvider.actualUser! is Speaker
    //       ? authProvider.actualUser!.user
    //       : authProvider.actualUser!;

    //   isAdmin = userApp.role == Roles.admin;
    // }

    return BottomNavigationBar(
      selectedItemColor: Colors.deepPurple,
      currentIndex: selectedIndex,
      onTap: (index) {
        onTabTapped(index);
        if (authProvider.isAuthenticated) {
          switch (index) {
            case 0:
              context.go('/lectures');
              break;
            case 1:
              context.go('/miniCourses');
              break;
            case 2:
              context.go('/events');
              break;
          }
        }
      },
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.event_note),
          label: 'Palestras',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.school_rounded),
          backgroundColor: Colors.deepPurple,
          label: 'Mini Cursos',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.festival),
          label: 'Setecs',
          backgroundColor: Colors.deepPurple,
        )
      ],
    );
  }
}
