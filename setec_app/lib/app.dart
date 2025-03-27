import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:setec_app/utils/functions/checkin_user_status.dart';
import 'package:setec_app/providers/main_provider.dart';
import 'package:setec_app/services/firebase/auth/auth_service.dart';
import 'package:setec_app/themes/light_theme.dart';
import 'package:setec_app/utils/routes/appRoutes/app_routes.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _MainAppState();
}

class _MainAppState extends State<App> {
  final AuthService _authService = AuthService();
  bool _isLoading = true;
  final Logger logger = Logger();

  @override
  void initState() {
    super.initState();

    // ✅ Executa a inicialização APÓS o primeiro frame para evitar erro de `context`
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initializeApp(context);
    });
  }

  Future<void> _initializeApp(BuildContext context) async {
    final mainProvider = Provider.of<MainProvider>(context, listen: false);

    try {
      CheckingUserStatus().setContext(context);

      if (mainProvider.isAuthenticated) {
        setState(() => _isLoading = false);
        return;
      }

      final currentUser = _authService.currentUser;
      if (currentUser != null) {
        await mainProvider.loadDataFromPreferences(context);
      }

      if (context.mounted) {
        mainProvider.fetchEvents(context: context);
      }
    } on Exception catch (error, stackTrace) {
      logger.e('Erro ao buscar dados do usuário: $error, $stackTrace');
    } finally {
      setState(() => _isLoading = false);
    }
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
