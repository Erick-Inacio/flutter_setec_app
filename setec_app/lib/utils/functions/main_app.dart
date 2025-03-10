import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:setec_app/utils/functions/checkin_user_status.dart';
import 'package:setec_app/utils/provider/auth_provider_model.dart';
import 'package:setec_app/services/firebase/auth/auth_service.dart';
import 'package:setec_app/themes/light_theme.dart';
import 'package:setec_app/utils/routes/appRoutes/app_routes.dart';

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  final AuthService _authService = AuthService();
  bool _isLoading = true;
  Logger logger = Logger();

  @override
  void initState() {
    super.initState();
    _checkUserLoggedIn();
  }

  void _checkUserLoggedIn() async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    if (authProvider.isAuthenticated) {
      setState(() {
        _isLoading = false;
      });
    }

    try {
      final user = _authService.currentUser;
      if (user != null) {
        await authProvider.loadUserFromPreferences();
      }
    } on Exception catch (e, stacktrace) {
      authProvider.signOut();
      logger.e('Main: Erro ao buscar dados do usuário: $e',
          stackTrace: stacktrace);
    }

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
   
    CheckingUserStatus().setContext(context);

    return _isLoading
        ? const Center(child: CircularProgressIndicator())
        : MaterialApp.router(
            debugShowCheckedModeBanner: false,
            routerConfig: AppRouter.router,
            theme: lightTheme,
          );
  }
}
