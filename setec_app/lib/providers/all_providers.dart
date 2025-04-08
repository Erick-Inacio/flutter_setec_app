import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:setec_app/ui/speaker/viewModel/speaker_provider.dart';
import 'package:setec_app/ui/userApp/viewModel/user_app_provider.dart';

class AllProviders extends StatelessWidget {
  final Widget child;

  const AllProviders({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // ChangeNotifierProvider(create: (_) => MainProvider()),
        // ChangeNotifierProvider(create: (_) => EventProvider()),
        ChangeNotifierProvider(create: (_) => SpeakerProvider()),
        ChangeNotifierProvider(create: (_) => UserAppProvider()),
        // ChangeNotifierProvider(create: (_) => ActivityProvider()),
      ],
      child: child,
    );
  }
}
