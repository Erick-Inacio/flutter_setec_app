import 'package:flutter/material.dart';

class EventsScreen extends StatefulWidget {
  const EventsScreen({super.key});

  @override
  State<EventsScreen> createState() => _EventsScreenState();
}

class _EventsScreenState extends State<EventsScreen> {
  final CarouselController controller = CarouselController(
    initialItem: 0,
  );

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.sizeOf(context).height;
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: <Widget>[
        ConstrainedBox(
          
          constraints: BoxConstraints(maxHeight: height / 3),
          child: CarouselView(
            // itemSnapping: true,
            // flexWeights: const <int>[1, 7, 1],
            controller: controller,
            itemExtent: height / 3,
            
            children: <Widget>[
              Container(
                color: Colors.redAccent,
              ),
              Container(
                color: Colors.deepPurple,
              ),
              Container(
                color: Colors.yellowAccent,
              ),
            ],
          ),
        ),
      ]),
    );
  }
}
