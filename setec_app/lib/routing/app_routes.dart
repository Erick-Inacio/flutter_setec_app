import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:setec_app/providers/auth_state_notifier.dart';
import 'package:setec_app/ui/auth/views/login_view.dart';
import 'package:setec_app/ui/_lecture/views/lecture_view.dart';
import 'package:setec_app/ui/_miniCourse/view/mini_course.dart';
import 'package:setec_app/ui/event/views/create_event_screen.dart';
import 'package:setec_app/ui/home/views/home_nav_drawer_view.dart';
import 'package:setec_app/ui/auth/views/create_account_view.dart';
import 'package:setec_app/ui/event/views/event_view.dart';

final appRouterProvider = Provider<GoRouter>(
  (ref) {
    final authNotifier = ref.watch(authListenableProvider);

    return GoRouter(
      debugLogDiagnostics: true,
      navigatorKey: GlobalKey<NavigatorState>(),
      initialLocation: '/home',
      refreshListenable: authNotifier,
      routes: [
        GoRoute(
          path: '/home',
          pageBuilder: (context, state) => MaterialPage(
            key: state.pageKey,
            child: const HomeNavDrawer(),
          ),
          routes: [
            GoRoute(
              path: '/lectures',
              pageBuilder: (context, state) => MaterialPage(
                key: state.pageKey,
                child: const LecturePage(),
              ),
            ),
            GoRoute(
              path: '/miniCourses',
              pageBuilder: (context, state) => MaterialPage(
                key: state.pageKey,
                child: const MiniCoursePage(),
              ),
            ),
            GoRoute(
              path: '/events',
              pageBuilder: (context, state) => MaterialPage(
                key: state.pageKey,
                child: EventView(),
              ),
            ),
          ],
        ),
        GoRoute(
          path: '/login',
          pageBuilder: (context, state) => MaterialPage(
            key: state.pageKey,
            child: const LoginWithEmail(),
          ),
        ),
        GoRoute(
          path: '/createAccount',
          pageBuilder: (context, state) => MaterialPage(
            key: state.pageKey,
            child: const CreateAccount(),
          ),
        ),
        GoRoute(
          path: '/createEvent',
          pageBuilder: (context, state) => MaterialPage(
            key: state.pageKey,
            child: const CreateEvent(),
          ),
        ),
      ],
    );
  },
);
