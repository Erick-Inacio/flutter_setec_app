import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:setec_app/ui/home/providers/home_provider.dart';

class BottomNavBarWidget extends ConsumerWidget {
  const BottomNavBarWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentIndex = ref.watch(navControllerProvider);
    final navNotifier = ref.read(navControllerProvider.notifier);

    return BottomNavigationBar(
      backgroundColor: Colors.deepPurple[50],
      currentIndex: currentIndex,
      onTap: (index) => navNotifier.navigate(index, context),
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
