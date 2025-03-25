import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:setec_app/models/event_model.dart';
import 'package:setec_app/models/speaker_model.dart';
import 'package:setec_app/models/user_app_model.dart';
import 'package:setec_app/providers/event_provider.dart';
import 'package:setec_app/providers/speaker_provider.dart';
import 'package:setec_app/providers/user_app_provider.dart';
import 'package:setec_app/services/firebase/auth/auth_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainProvider with ChangeNotifier {
  dynamic _user;
  List<Event> _events = [];

  dynamic get actualUser => _user;
  List<Event> get events => _events;

  bool get isAuthenticated => _user != null;
  bool get isSpeaker => _user is Speaker;

  final logger = Logger();

  void setUserApp(BuildContext context, UserApp userApp) async {
    try {
      final userAppProvider =
          Provider.of<UserAppProvider>(context, listen: false);
      await userAppProvider.saveDataToLocal(userApp);

      logger
          .i('Usuário logado com sucesso: ${userAppProvider.data.toString()}');
      _user = userApp;
      notifyListeners();
    } catch (e) {
      logger.e('Erro ao setar UserApp: $e');
      rethrow;
    }
  }

  void setSpeaker(BuildContext context, Speaker speaker) async {
    try {
      Provider.of<SpeakerProvider>(context, listen: false)
          .saveDataToLocal(speaker);
      _user = speaker;
      notifyListeners();
    } catch (e) {
      logger.e('Erro ao setar Speaker: $e');
      rethrow;
    }
  }

  void fetchEvents({
    required BuildContext context,
  }) async {
    try {
      final eventProvider = Provider.of<EventProvider>(context, listen: false);
      await eventProvider.fetchEvents();
      _events = eventProvider.events;
      notifyListeners();
    } catch (e) {
      logger.e('Erro ao setar eventos: $e');
      rethrow;
    }
  }

  Future<void> loadDataFromPreferences(BuildContext context) async {
    try {
      final userAppProvider =
          Provider.of<UserAppProvider>(context, listen: false);
      final speakerProvider =
          Provider.of<SpeakerProvider>(context, listen: false);
      final eventProvider = Provider.of<EventProvider>(context, listen: false);

      logger.i("🔍 Carregando usuário do armazenamento local...");
      final userAppData = await userAppProvider.loadDataFromLocal();

      if (userAppData != null) {
        logger.i("✅ Usuário encontrado: ${userAppData.toString()}");
        _user = UserApp.fromJson(userAppData);
      } else {
        logger.i("⚠️ Nenhum usuário encontrado, buscando palestrante...");
        final speakerData = await speakerProvider.loadDataFromLocal();
        if (speakerData != null) {
          logger.i("✅ Palestrante encontrado: $speakerData");
          _user = Speaker.fromJson(speakerData);
        } else {
          logger.w(
              "⚠️ Nenhum usuário ou palestrante encontrado. Definindo `_user` como `null`.");
          _user = null;
        }
      }

      logger.i("🔍 Carregando eventos do armazenamento local...");
      final eventsData = await eventProvider.loadEventsFromLocal();

      if (eventsData != null) {
        _events = eventsData;
        logger.i("✅ Eventos encontrados: ${eventsData.length}");
        
      } else {
        logger.w(
            "⚠️ Nenhum evento encontrado no armazenamento local, buscando da API...");
        await eventProvider
            .fetchEvents();
        _events = eventProvider.events;
      }

      notifyListeners();
      logger.i("🎉 Dados carregados com sucesso!");
    } catch (e, stackTrace) {
      logger.e('❌ Erro ao carregar dados locais: $e',
          error: e, stackTrace: stackTrace);
      rethrow;
    }
  }

  Future<void> signOut() async {
    try {
      final authService = AuthService();
      await authService.logout();
      _user = null;
      final prefs = await SharedPreferences.getInstance();
      await prefs.clear();
      notifyListeners();
    } catch (e) {
      logger.e('Erro ao deslogar usuário local + firebase: $e');
      rethrow;
    }
  }
}
