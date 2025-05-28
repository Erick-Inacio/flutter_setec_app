import 'package:flutter/material.dart';

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
    // final mainProvider = context.read<MainProvider>();

    // bool isAdmin = false;

    // UserApp userApp = UserApp.empty();
    // if (mainProvider.actualUser != null) {
    //   userApp = mainProvider.actualUser! is Speaker
    //       ? mainProvider.actualUser!.user
    //       : mainProvider.actualUser!;

    //   isAdmin = userApp.role == Roles.admin;
    // }

    return BottomNavigationBar(
      selectedItemColor: Colors.deepPurple,
      currentIndex: selectedIndex,
      onTap: (index) {
        onTabTapped(index);
        // if (mainProvider.isAuthenticated) {
        //   switch (index) {
        //     case 0:
        //       context.go('/lectures');
        //       break;
        //     case 1:
        //       context.go('/miniCourses');
        //       break;
        //     case 2:
        //       context.go('/events');
        //       break;
        //   }
        // }
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
