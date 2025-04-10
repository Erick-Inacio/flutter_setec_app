import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:setec_app/firebase_options.dart';
import 'package:setec_app/initialize/app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    // Inicializa o firebase
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    //Carrega o arquivo .env
    await dotenv.load(fileName: ".env");
  } on Exception {
    rethrow;
  }

  runApp(
    ProviderScope(
      child: App(),
    ),
  );
}
