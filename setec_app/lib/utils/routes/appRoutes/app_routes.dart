import 'package:go_router/go_router.dart';
import 'package:setec_app/screens/admin/admin_user_menager_screen.dart';
import 'package:setec_app/screens/bottomNavBar/miniCourse/mini_course.dart';
import 'package:setec_app/screens/home/home_page.dart';
import 'package:setec_app/utils/provider/auth_provider_model.dart';
import 'package:setec_app/models/user_app_model.dart';
import 'package:setec_app/screens/auth/emailAndPassword/createAccount/create_account_screen.dart';
import 'package:setec_app/screens/auth/emailAndPassword/createAccount/create_user.dart';
import 'package:setec_app/screens/bottomNavBar/event/event_screen.dart';
import 'package:setec_app/screens/auth/login_options.dart';
import 'package:setec_app/screens/auth/emailAndPassword/login_with_email.dart';
import 'package:setec_app/screens/bottomNavBar/lecture/lectures_screen.dart';

class AppRouter {
  static GoRouter get router => _router;

  static final GoRouter _router = GoRouter(
    initialLocation: '/lectures',
    refreshListenable: AuthProvider(),
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
      ShellRoute(
        builder: (context, state, child) {
          return HomePageNavBar(child: child);
        },
        routes: <GoRoute>[
          GoRoute(
            path: '/lectures',
            builder: (context, state) {
              return const LectureScreen();
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
