import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:setec_app/ui/event/views/event_view.dart';
import 'package:setec_app/ui/_lecture/views/lecture_view.dart';
import 'package:setec_app/ui/_miniCourse/view/mini_course.dart';

final currentIndexProvider = StateProvider<int>((ref) => 0);

final appBarTitlesProvider = Provider<List<String>>(
  (ref) => [
    'Agenda de Palestras',
    'Mini Cursos',
    'Eventos',
  ],
);

final viewsProvider = Provider<List<Widget>>(
  (ref) => [
    const LecturePage(),
    const MiniCoursePage(),
    const EventView(),
  ],
);


