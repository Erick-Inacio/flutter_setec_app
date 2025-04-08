import 'package:go_router/go_router.dart';
import 'package:setec_app/domain/models/user_app.dart';
import 'package:setec_app/ui/admin/views/admin_user_menager_screen.dart';
import 'package:setec_app/ui/event/views/create_event_screen.dart';
import 'package:setec_app/ui/lecture/views/lecture_view.dart';
import 'package:setec_app/ui/miniCourse/view/mini_course.dart';
import 'package:setec_app/ui/home/views/home_page.dart';
import 'package:setec_app/ui/auth/views/create_account_screen.dart';
import 'package:setec_app/ui/auth/views/create_user.dart';
import 'package:setec_app/ui/event/views/event_screen.dart';
import 'package:setec_app/ui/auth/views/login_options.dart';
import 'package:setec_app/ui/auth/views/login_with_email.dart';

class AppRouter {
  static GoRouter get router => _router;

  static final GoRouter _router = GoRouter(
    initialLocation: '/lectures',
    // refreshListenable: MainProvider(),
    debugLogDiagnostics: true,
    routes: [
      GoRoute(
        path: '/loginOptions',
        builder: (context, state) => const LoginOptions(),
      ),
      GoRoute(
        path: '/adminUser',
        builder: (context, state) => const AdminUserManager(),
      ),
      GoRoute(
        path: '/loginWithEmail',
        builder: (context, state) => LoginWithEmail(),
      ),
      GoRoute(
        path: '/criarConta',
        builder: (context, state) => CreateAccount(),
      ),
      GoRoute(
        path: '/createUser',
        builder: (context, state) {
          final map = state.extra as Map<String, dynamic>;
          final userApp = map['user'] as UserApp;
          final password = map['password'] as String;
          return CreateUser(userApp: userApp, password: password);
        },
      ),
      GoRoute(
        path: '/createEvent',
        builder: (context, state) => const CreateEvent(),
      ),
      ShellRoute(
        builder: (context, state, child) {
          return HomePageNavBar(child: child);
        },
        routes: <GoRoute>[
          GoRoute(
            path: '/lectures',
            builder: (context, state) {
              return const LectureView();
            },
          ),
          GoRoute(
            path: '/miniCourses',
            builder: (context, state) {
              return const MiniCourse();
            },
          ),
          GoRoute(
            path: '/events',
            builder: (context, child) {
              return ManageEvents();
            },
          ),

          // GoRoute(
          //   path: '/user',
          //   builder: (context, state) {
          //     final map = state.extra as Map<String, dynamic>;
          //     Logger().i(map);
          //     BuildContext? context = map['context'] as BuildContext?;
          //     dynamic user = map['user'] as dynamic;
          //     return UserScreen(
          //       user: user,
          //       parentContext: context,
          //     );
          //   },
          // ),

          // GoRoute(
          //   path: '/adminMenu',
          //   builder: (context, state) {
          //     return const AdminUserManager();
          //   },
          // )
        ],
      ),
    ],
  );
}
