import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:setec_app/providers/event_provider.dart';
import 'package:setec_app/ui/event/widgets/event_card.dart';

class EventView extends ConsumerStatefulWidget {
  const EventView({super.key});

  @override
  ConsumerState<EventView> createState() => _EventView();
}

class _EventView extends ConsumerState<EventView> {
  @override
  Widget build(BuildContext context) {
    final events = ref.watch(eventNotifier);
    return Scaffold(
      body: Column(
        children: <Widget>[
          ListView.builder(
            shrinkWrap: true,
            itemCount: events.length,
            itemBuilder: (context, index) {
              return (index == events.length - 1)
                  ? EventCard(event: events[index], isFinalEvent: true)
                  : EventCard(event: events[index]);
            },
          ),
        ],
      ),
    );
  }
}
