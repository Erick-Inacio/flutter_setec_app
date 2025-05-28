import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

// final navControllerProvider = StateProvider<int>((ref) => 0);

final appBarTitlesProvider = Provider<List<String>>(
  (ref) => [
    'Agenda de Palestras',
    'Mini Cursos',
    'Eventos',
  ],
);

// final viewsProvider = Provider<List<Widget>>(
//   (ref) => [
//     const LecturePage(),
//     const MiniCoursePage(),
//     const EventView(),
//   ],
// );
final navControllerProvider = StateNotifierProvider<NavController, int>((ref) {
  return NavController();
});

class NavController extends StateNotifier<int> {
  NavController() : super(0);

  // Safe method to update state
  void safeUpdateIndex(int newIndex) {
    if (state != newIndex) {
      state = newIndex;
    }
  }

  void navigate(int index, BuildContext context) {
    safeUpdateIndex(index);
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
}
