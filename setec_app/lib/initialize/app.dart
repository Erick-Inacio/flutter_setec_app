import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:setec_app/core/mixins/restore_from_local_mixin.dart';
import 'package:setec_app/routing/app_routes.dart';
import 'package:setec_app/ui/utils/themes/light_theme.dart';

class App extends ConsumerStatefulWidget {
  const App({super.key});

  @override
  ConsumerState<App> createState() => _App();
}

class _App extends ConsumerState<App> with RestoreDataFromLocal {
  @override
  void initState() {
    restoreFromLocal(ref);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final goRouter = ref.watch(appRouterProvider);

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: goRouter,
      theme: lightTheme,
    );
  }
}
