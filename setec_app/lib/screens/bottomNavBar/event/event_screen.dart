import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:setec_app/models/event_model.dart';
import 'package:setec_app/providers/event_provider.dart';
import 'package:setec_app/widgets/cards/event_card.dart';

class ManageEvents extends StatefulWidget {
  const ManageEvents({super.key});

  @override
  State<ManageEvents> createState() => _ManageEventsState();
}

class _ManageEventsState extends State<ManageEvents> {
  @override
  Widget build(BuildContext context) {
    final eventProvider = context.watch<EventProvider>();
    final events = eventProvider.events;

    return Scaffold(
      body: events.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              shrinkWrap: true,
              itemCount: events.length,
              itemBuilder: (context, index) {
                return (index == events.length - 1)
                    ? EventCard(event: events[index], isFinalEvent: true)
                    : EventCard(event: events[index]);
              },
            ),
    );
  }
}
