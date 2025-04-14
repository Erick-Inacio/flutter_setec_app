import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BottomNavBarWidget extends ConsumerWidget {
  final int currentIndex;
  final Function(int) onTap;

  const BottomNavBarWidget({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return BottomNavigationBar(
      backgroundColor: Colors.deepPurple[50],
      currentIndex: currentIndex,
      onTap: onTap,
      items: [
        BottomNavigationBarItem(
          backgroundColor: Colors.deepPurple[50],
          icon: Icon(Icons.calendar_month),
          label: 'Palestras',
        ),
        BottomNavigationBarItem(
          backgroundColor: Colors.deepPurple[50],
          icon: Icon(Icons.school_rounded),
          label: 'Mini Cursos',
        ),
        BottomNavigationBarItem(
          backgroundColor: Colors.deepPurple[50],
          icon: Icon(Icons.festival),
          label: 'Setecs',
        ),
      ],
    );
  }
}
