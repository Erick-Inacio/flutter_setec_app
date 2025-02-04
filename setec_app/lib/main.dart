import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:setec_app/firebase_options.dart';
import 'package:setec_app/models/auth_provider_model.dart';
import 'package:setec_app/models/user_app_model.dart';
import 'package:setec_app/screens/home_page.dart';
import 'package:setec_app/screens/login_options.dart';
import 'package:setec_app/services/backend/user_service.dart';
import 'package:setec_app/services/firebase/auth/auth_service.dart';

Future<void> main() async {
  Logger logger = Logger();
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  } catch (e) {
    logger.e('Failed to initialize Firebase: $e');
    return;
  }

  final authProvider = AuthProvider();
  try {
    await authProvider.loadUserFromPreferences();
  } catch (e) {
    logger.e('Failed to load user from preferences: $e');
  }

  runApp(ChangeNotifierProvider(
    create: (context) => authProvider,
    child: const MainApp(),
  ));
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
        _isLoading = true;
      });
    }

    try {
      final user = _authService.currentUser;
      if (user != null) {
        UserApp? userApp = await UserServices.getUser(user.uid);

        authProvider.setUserApp(userApp);
      }
    } on Exception catch (e, stacktrace) {
      authProvider.signOut();
      logger.e("Erro ao buscar dados do usuário: $e", stackTrace: stacktrace);
    }

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = context.watch<AuthProvider>();
    Logger logger = Logger();
    logger.i(authProvider.userApp.toString());

    if (_isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    if (authProvider.isAuthenticated) {
      return const MaterialApp(
          debugShowCheckedModeBanner: false, home: HomePage());
    } else {
      return const MaterialApp(
          debugShowCheckedModeBanner: false, home: LoginOptions());
    }
  }
}
