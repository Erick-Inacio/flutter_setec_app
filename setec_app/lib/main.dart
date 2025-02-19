import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:setec_app/firebase_options.dart';
import 'package:setec_app/models/auth_provider_model.dart';
import 'package:setec_app/models/user_app_model.dart';
import 'package:setec_app/services/backend/user_service.dart';
import 'package:setec_app/services/firebase/auth/auth_service.dart';
import 'package:setec_app/services/routes/appRoutes/app_routes.dart';
import 'package:setec_app/themes/light_theme.dart';

Future<void> main() async {
  Logger logger = Logger();
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  } catch (e) {
    logger.e('Main: Failed to initialize Firebase: $e');
    return;
  }

  final authProvider = AuthProvider();
  try {
    await authProvider.loadUserFromPreferences();
  } catch (e) {
    logger.e('Main: Failed to load user from preferences: $e');
  }

  // await dotenv.load(fileName: "A:/flutter_setec_app/setec_app/lib/assets/.env");
  runApp(
    ChangeNotifierProvider(
      create: (context) => authProvider,
      child: const MainApp(),
    ),
  );
}

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
        UserApp? userApp = await UserServices.getUser(user.uid);

        authProvider.setUserApp(userApp);
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
    // Logger logger = Logger();
    // ignore: unused_local_variable
    final authProvider = context.watch<AuthProvider>();
    // logger.e('Main: Testando na Main: ${authProvider.userApp}');

    return _isLoading
        ? const Center(child: CircularProgressIndicator())
        : MaterialApp.router(
            debugShowCheckedModeBanner: false,
            routerConfig: AppRouter.router,
            theme: lightTheme,
          );
  }
}
