import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:logger/logger.dart';
import 'package:setec_app/models/auth_provider_model.dart';
import 'package:setec_app/models/user_app_model.dart';
import 'package:setec_app/screens/admin/admin_user_menager_screen.dart';
import 'package:setec_app/screens/auth/emailAndPassword/createAccount/create_account_screen.dart';
import 'package:setec_app/screens/auth/emailAndPassword/createAccount/create_user.dart';
import 'package:setec_app/screens/home/home_page.dart';
import 'package:setec_app/screens/auth/login_options.dart';
import 'package:setec_app/screens/auth/emailAndPassword/login_with_email.dart';
import 'package:setec_app/screens/user/user_screen.dart';

class AppRouter {
  static GoRouter get router => _router;

  static final GoRouter _router = GoRouter(
    initialLocation: '/home',
    refreshListenable: AuthProvider(),
    debugLogDiagnostics: true,
    routes: <GoRoute>[
      GoRoute(
        path: '/home',
        builder: (context, state) {
          return HomePage();
        },
      ),
      GoRoute(
        path: '/loginOptions',
        builder: (context, state) => const LoginOptions(),
      ),
      GoRoute(
        path: '/user',
        builder: (context, state) {
          final map = state.extra as Map<String, dynamic>;
          Logger().i(map);
          BuildContext? context = map['context'] as BuildContext?;
          dynamic user = map['user'] as dynamic;
          return UserScreen(user: user, parentContext: context);
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
      GoRoute(
        path: '/createUser',
        builder: (context, state) {
          final map = state.extra as Map<String, dynamic>;
          final userApp = map['user'] as UserApp;
          final password = map['password'] as String;
          return CreateUser(userApp: userApp, password: password);
        },
      ),
      // GoRoute(
      //   path: '/infoSpeaker',
      //   builder: (context, state) {
      //     final context = state.extra as BuildContext;
      //     return InfoSpeaker(
      //       parentContext: context,
      //     );
      //   },
      // ),
    ],
  );
}
