import 'package:go_router/go_router.dart';
import 'package:setec_app/models/auth_provider_model.dart';
import 'package:setec_app/models/user_app_model.dart';
import 'package:setec_app/screens/admin/admin_user_menager_screen.dart';
import 'package:setec_app/screens/auth/create_account_screen.dart';
import 'package:setec_app/screens/home/home_page.dart';
import 'package:setec_app/screens/auth/login_options.dart';
import 'package:setec_app/screens/auth/login_with_email.dart';
import 'package:setec_app/screens/speaker/create_speaker.dart';
import 'package:setec_app/screens/user/user_screen.dart';

class AppRouter {
  static final GoRouter _router = GoRouter(
    routes: <GoRoute>[
      GoRoute(
        path: '/home',
        builder: (context, state) => const HomePage(),
      ),
      GoRoute(
        path: '/loginOptions',
        builder: (context, state) => const LoginOptions(),
      ),
      GoRoute(
        path: '/user',
        builder: (context, state) {
          final userApp = state.extra as UserApp;
          return UserScreen(user: userApp);
        },
      ),
      GoRoute(
        path: '/createSpeaker',
        builder: (context, state) {
          final userApp = state.extra as UserApp;
          return CreateSpeaker(userApp: userApp);
        },
      ),
      
      GoRoute(
        path: '/adminUser',
        builder: (context, state) => const AdminUserMenager(),
      ),
      GoRoute(
        path: '/loginWithEmail',
        builder: (context, state) => LoginWithEmail(),
      ),
      GoRoute(
        path: '/criarConta',
        builder: (context, state) => CreateAccount(),
      ),
    ],
    initialLocation: '/home',
    refreshListenable: AuthProvider(),
    debugLogDiagnostics: true,
    // redirect: (context, state) {
    // final authProvider = context.read<AuthProvider>();
    // final isAuthenticated = authProvider.isAuthenticated;
    // final isFirstCheck = authProvider.isFirstCheck;

    // if (isFirstCheck) {
    //   return null;
    // }

    // if (isAuthenticated && authProvider.userApp!.role == Roles.admin) {
    //   return '/adminUser';
    // }
    // if (isAuthenticated && authProvider.userApp != null) {
    //   return '/home';
    // }

    // final publicRoutes = {'/loginOptions', '/loginWithEmail', '/criarConta'};

    // if (publicRoutes.contains(state.matchedLocation)) {
    //   return null;
    // }

    // return '/home';
    // },
  );
  static GoRouter get router => _router;
}
