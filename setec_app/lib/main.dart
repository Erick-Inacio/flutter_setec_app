import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:setec_app/firebase_options.dart';
import 'package:setec_app/utils/provider/auth_provider_model.dart';
import 'package:setec_app/utils/functions/main_app.dart';

Future<void> main() async {
  //Para usuário local
  final authProvider = AuthProvider();

  WidgetsFlutterBinding.ensureInitialized();

  try {
    await Future.wait(
      [
        // Inicializa o firebase
        Firebase.initializeApp(
          options: DefaultFirebaseOptions.currentPlatform,
        ),

        //procura e/ou tenta recuperar o user local
        authProvider.loadUserFromPreferences(),

        //Carrega o arquivo .env
        dotenv.load(fileName: ".env"),
      ],
    );
  } on Exception {
    rethrow;
  }

  runApp(
    //Carrega o gerenciador de estado e
    //inicia a aplicação
    ChangeNotifierProvider(
      create: (context) => authProvider,
      child: const MainApp(),
    ),
  );
}
