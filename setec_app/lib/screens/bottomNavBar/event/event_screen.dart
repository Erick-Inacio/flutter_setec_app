import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:setec_app/models/event_model.dart';
import 'package:setec_app/services/backend/event_services.dart';
import 'package:setec_app/widgets/cards/event_card.dart';

class ManageEvents extends StatefulWidget {
  const ManageEvents({super.key});

  @override
  State<ManageEvents> createState() => _ManageEventsState();
}

class _ManageEventsState extends State<ManageEvents> {
  bool isLoading = false;

  List<Event> events = [];

  @override
  void initState() {
    super.initState();

    _getEvents();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: events.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              shrinkWrap: true,
              itemCount: events.length,
              itemBuilder: (context, index) {
                if (events.isNotEmpty) {
                  isLoading = false;
                  !(index == events.length - 1)
                      ? EventCard(event: events[index])
                      : EventCard(
                          event: events[index],
                          isFinalEvent: true,
                        );
                }
              },
            ),
    );
  }

  Future<void> _getEvents() async {
    try {
      final eventService = EventServices();

      events = await eventService.getAll();
    } on Exception catch (e) {
      Logger().e('ManageEvents: $e');
    }
  }
}
