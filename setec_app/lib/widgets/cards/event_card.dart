import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:setec_app/models/event_model.dart';
import 'package:setec_app/utils/functions/global_methods.dart';

class EventCard extends StatefulWidget {
  final Event event;
  final bool isFinalEvent;

  const EventCard({
    super.key,
    required this.event,
    this.isFinalEvent = false,
  });

  @override
  State<EventCard> createState() => _EventCardState();
}

class _EventCardState extends State<EventCard> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: () {},
          child: Card(
            margin: const EdgeInsets.all(8),
            child: Column(
              children: <Widget>[
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      widget.event.description,
                      style: GoogleFonts.lato(),
                    ),
                  ),
                ),
                SizedBox(height: 8),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: <Widget>[
                          Text('Data Inicial'),
                          SizedBox(height: 8),
                          Text(
                            GlobalMethods.formatDate(
                              widget.event.initialDateTime,
                            ),
                          ),
                        ],
                      ),
                      Spacer(),
                      Column(
                        children: <Widget>[
                          Text('Data Final'),
                          SizedBox(height: 8),
                          Text(
                            GlobalMethods.formatDate(
                              widget.event.finalDateTime,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        widget.isFinalEvent ? SizedBox(height: 12) : Container(),
      ],
    );
  }
}
