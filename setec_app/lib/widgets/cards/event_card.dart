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
          onLongPress: () {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: Text(
                  'Opções para Evento',
                  style: GoogleFonts.lato(),
                ),
                actions: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    spacing: double.minPositive,
                    children: <Widget>[
                      ListTile(
                        minTileHeight: MediaQuery.sizeOf(context).height / 30,
                        leading: const Icon(
                          Icons.edit,
                          color: Colors.deepPurple,
                        ),
                        title: const Text('Editar'),
                        onTap: () => Navigator.pop(context),
                      ),
                      ListTile(
                        minTileHeight: MediaQuery.sizeOf(context).height / 30,
                        leading: const Icon(
                          Icons.delete,
                          color: Colors.deepPurple,
                        ),
                        title: const Text('Excluir'),
                        onTap: () => Navigator.pop(context),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      TextButton(
                        child: const Text(
                          'Fechar',
                          style: TextStyle(color: Colors.deepPurple),
                        ),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
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
