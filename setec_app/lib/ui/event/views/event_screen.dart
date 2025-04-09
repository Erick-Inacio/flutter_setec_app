import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:setec_app/providers/session_provider.dart';
import 'package:setec_app/ui/utils/ui/widgets/cards/event_card.dart';

class ManageEvents extends StatefulWidget {
  const ManageEvents({super.key});

  @override
  State<ManageEvents> createState() => _ManageEventsState();
}

class _ManageEventsState extends State<ManageEvents> {
  @override
  Widget build(BuildContext context) {
    // final mainProvider = context.watch<MainProvider>();
    // final events = mainProvider.events;

    return Container();
    // Scaffold(
    //   body: ListView.builder(
    //     shrinkWrap: true,
    //     itemCount: events.length,
    //     itemBuilder: (context, index) {
    //       return (index == events.length - 1)
    //           ? EventCard(event: events[index], isFinalEvent: true)
    //           : EventCard(event: events[index]);
    //     },
    //   ),
    // );
  }
}
