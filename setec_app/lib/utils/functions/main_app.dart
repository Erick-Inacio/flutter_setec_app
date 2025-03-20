import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:setec_app/utils/functions/checkin_user_status.dart';
import 'package:setec_app/providers/main_provider.dart';
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
      // ✅ Configura o contexto no Singleton CheckingUserStatus
      CheckingUserStatus().setContext(context);

      // ✅ Se já está autenticado, não precisa verificar novamente
      if (mainProvider.isAuthenticated) {
        setState(() => _isLoading = false);
        return;
      }

      // ✅ Verifica se há um usuário logado no Firebase
      final currentUser = _authService.currentUser;
      if (currentUser != null) {
        await mainProvider.loadDataFromPreferences(context);
      }
    } catch (error, stackTrace) {
      mainProvider.signOut();
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
