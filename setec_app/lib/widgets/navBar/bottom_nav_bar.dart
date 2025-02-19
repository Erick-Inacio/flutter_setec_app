import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:setec_app/models/auth_provider_model.dart';

class BottomNavBar extends StatelessWidget {
  final int currentIndex;

  const BottomNavBar({
    super.key,
    required this.currentIndex,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      selectedItemColor: Colors.deepPurple,
      backgroundColor: Colors.deepPurple.shade50,
      currentIndex: currentIndex,
      onTap: (index) {
        final authProvider = context.read<AuthProvider>();
        if (authProvider.isAuthenticated) {
          switch (index) {
            case 0:
              context.go('/home');
              break;
            case 1:
              context.go('/user', extra: authProvider.userApp);
              break;
          }
        } else {
          context.go('/loginOptions');
        }
      },
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Perfil',
          backgroundColor: Colors.deepPurple,
        ),
      ],
    );
  }
}
