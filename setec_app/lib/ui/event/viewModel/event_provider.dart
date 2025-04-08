// import 'dart:convert';

// import 'package:setec_app/data/event/dto/event_dto.dart';
// import 'package:setec_app/data/event/service/event_services.dart';
// import 'package:setec_app/domain/models/event.dart';
// import 'package:setec_app/core/base/base_provider.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class EventProvider extends BaseProvider<EventDTO> {
//   List<EventDTO> eventsDTO = [];

//   EventProvider()
//       : super(
//           field: 'event',
//           service: EventServices(),
//           fromJson: EventDTO.fromJson,
//           toJson: (eventDTO) => eventDTO.toJson(),
//         );

//   Future<void> fetchEvents() async {
//     try {
//       events = await EventServices().getEventsWithNoAuth();
//       final prefs = await SharedPreferences.getInstance();
//       await prefs.setString(
//           'event', jsonEncode(events.map((e) => e.toJson()).toList()));
//       notifyListeners();
//     } on Exception catch (e) {
//       throw Exception("Erro ao buscar lista de eventos: $e");
//     }
//   }

//   Future<void> saveEventsToLocal(List<Event> events) async {
//     final prefs = await SharedPreferences.getInstance();

//     try {
//       final eventList = {
//         'events': events.map((e) => e.toJson()).toList(),
//       };

//       await prefs.setString(field, jsonEncode(eventList));
//       await prefs.setString('dataType', field);
//     } on Exception catch (e) {
//       logger.e('Erro ao salvar os dados: $e');
//       await prefs.remove(field);
//       await prefs.remove('dataType');
//       rethrow;
//     }
//   }

//   Future<List<Event>?> loadEventsFromLocal() async {
//     SharedPreferences? sharedPreferences;

//     try {
//       sharedPreferences = await SharedPreferences.getInstance();
//       final storedData = sharedPreferences.getString(field);

//       if (storedData != null) {
//         final decodedData = jsonDecode(storedData);
//         if (decodedData is List) {
//           final events = decodedData
//               .map((event) => Event.fromJson(event as Map<String, dynamic>))
//               .toList();
//           notifyListeners();
//           return events;
//         }
//       }
//       return null;
//     } catch (error) {
//       sharedPreferences?.remove(field);
//       sharedPreferences?.remove('dataType');
//       rethrow;
//     }
//   }


// }
