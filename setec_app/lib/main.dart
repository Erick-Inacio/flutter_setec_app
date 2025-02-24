import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:setec_app/firebase_options.dart';
import 'package:setec_app/models/auth_provider_model.dart';
import 'package:setec_app/services/firebase/auth/auth_service.dart';
import 'package:setec_app/utils/routes/appRoutes/app_routes.dart';
import 'package:setec_app/themes/light_theme.dart';

Future<void> main() async {
  Logger logger = Logger();

  // Inicializa o firebase
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  } catch (e) {
    logger.e('Main: Failed to initialize Firebase: $e');
    return;
  }

  // Carrega o usuario local autenticado
  final authProvider = AuthProvider();
  try {
    await authProvider.loadUserFromPreferences();
  } catch (e) {
    logger.e('Main: Failed to load user from preferences: $e');
  }

  //Carrega o arquivo .env
  await dotenv.load(fileName: ".env");
  runApp(
    //Carrega o gerenciador de estado e inicia a aplicação
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
    return _isLoading
        ? const Center(child: CircularProgressIndicator())
        : MaterialApp.router(
            debugShowCheckedModeBanner: false,
            routerConfig: AppRouter.router,
            theme: lightTheme,
          );
  }
}
