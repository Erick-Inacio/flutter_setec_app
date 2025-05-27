import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:setec_app/model/models/speaker/speaker.dart';
import 'package:setec_app/ui/_lecture/views/lecture_view.dart';
import 'package:setec_app/ui/_miniCourse/view/mini_course.dart';
import 'package:setec_app/ui/auth/views/create_account_view.dart';
import 'package:setec_app/ui/auth/views/login_view.dart';
import 'package:setec_app/ui/event/views/create_event_screen.dart';
import 'package:setec_app/ui/event/views/event_view.dart';
import 'package:setec_app/ui/home/providers/home_provider.dart';
import 'package:setec_app/ui/home/views/home_nav_drawer_view.dart';
import 'package:setec_app/ui/speaker/views/speaker_profile_view.dart';
import 'package:setec_app/ui/speaker/views/speakers_view.dart';
import 'package:setec_app/ui/user/views/user_profile_view.dart';

final appRouterProvider = Provider<GoRouter>(
  (ref) {
    return GoRouter(
      initialLocation: '/lectures',
      routes: [
        StatefulShellRoute.indexedStack(
          builder: (context, state, navigationShell) {
            // Schedule the index update for after build
            WidgetsBinding.instance.addPostFrameCallback((_) {
              final index = switch (state.uri.toString()) {
                '/lectures' => 0,
                '/miniCourses' => 1,
                '/events' => 2,
                _ => 0,
              };
              ref.read(navControllerProvider.notifier).safeUpdateIndex(index);
            });

            return HomeNavDrawer(child: navigationShell);
          },
          branches: [
            StatefulShellBranch(routes: [
              GoRoute(
                path: '/lectures',
                builder: (context, state) => const LecturePage(),
              ),
            ]),
            StatefulShellBranch(routes: [
              GoRoute(
                path: '/miniCourses',
                pageBuilder: (context, state) => const NoTransitionPage(
                  child: MiniCoursePage(),
                ),
              ),
            ]),
            StatefulShellBranch(routes: [
              GoRoute(
                path: '/events',
                pageBuilder: (context, state) => const NoTransitionPage(
                  child: EventView(),
                ),
              ),
            ]),
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
        GoRoute(
          path: '/speakerProfile',
          pageBuilder: (context, state) {
            final speaker = state.extra as Speaker;
            return MaterialPage(
              key: state.pageKey,
              child: SpeakerProfileView(
                speaker: speaker,
              ),
            );
          },
        ),
        GoRoute(
          path: '/speakers',
          pageBuilder: (context, state) => MaterialPage(
            key: state.pageKey,
            child: const SpeakersView(),
          ),
        ),
        GoRoute(
          path: '/userProfile',
          pageBuilder: (context, state) => MaterialPage(
            key: state.pageKey,
            child: const UserProfileView(),
          ),
        )
      ],
    );
  },
);
