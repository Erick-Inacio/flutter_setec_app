import 'dart:convert';

import 'package:setec_app/models/event_model.dart';
import 'package:setec_app/providers/base_provider.dart';
import 'package:setec_app/services/backend/event_services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EventProvider extends BaseProvider<Event> {
  List<Event> events = [];

  EventProvider()
      : super(
          field: 'event',
          service: EventServices(),
          fromJson: Event.fromJson,
          toJson: (event) => event.toJson(),
        );

  Future<void> fetchEvents() async {
    try {
      events = await service.getAll() as List<Event>;
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(
          'event', jsonEncode(events.map((e) => e.toJson()).toList()));
      notifyListeners();
    } on Exception catch (e) {
      throw Exception("Erro ao buscar lista de eventos: $e");
    }
  }

  Future<void> saveEventsToLocal(List<Event> events) async {
    final prefs = await SharedPreferences.getInstance();

    try {
      final eventList = {
        'events': events.map((e) => e.toJson()).toList(),
      };

      await prefs.setString(field, jsonEncode(eventList));
      await prefs.setString('dataType', field);
    } on Exception catch (e) {
      logger.e('Erro ao salvar os dados: $e');
      await prefs.remove(field);
      await prefs.remove('dataType');
      rethrow;
    }
  }
}
