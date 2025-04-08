import 'package:flutter/material.dart';
import 'package:setec_app/routing/app_routes.dart';
import 'package:setec_app/ui/core/themes/light_theme.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: AppRouter.router,
      theme: lightTheme,
    );
  }
}
