import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:logger/web.dart';
import 'package:provider/provider.dart';
import 'package:setec_app/models/event_model.dart';
import 'package:setec_app/providers/main_provider.dart';
import 'package:setec_app/services/backend/event_services.dart';
import 'package:setec_app/utils/functions/checkin_user_status.dart';
import 'package:setec_app/utils/functions/global_methods.dart';
import 'package:setec_app/widgets/snackBar/exception_snack_bar.dart';

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
    final mainProvider = context.watch<MainProvider>();
    return Column(
      children: [
        InkWell(
          onTap: () {},
          onLongPress: () {
            CheckingUserStatus().isAdmin()
                ? showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text(
                        'Opções para Evento',
                        style: GoogleFonts.lato(),
                      ),
                      actions: <Widget>[
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          spacing: double.minPositive,
                          children: <Widget>[
                            ListTile(
                              minTileHeight:
                                  MediaQuery.sizeOf(context).height / 30,
                              leading: const Icon(
                                Icons.edit,
                                color: Colors.deepPurple,
                              ),
                              title: const Text('Editar'),
                              onTap: () => Navigator.pop(context),
                            ),
                            ListTile(
                              minTileHeight:
                                  MediaQuery.sizeOf(context).height / 30,
                              leading: const Icon(
                                Icons.delete,
                                color: Colors.deepPurple,
                              ),
                              title: const Text('Excluir'),
                              onTap: () async {
                                final eventServices = EventServices();

                                try {
                                  await eventServices.delete(
                                    widget.event.id as int,
                                  );

                                  if (context.mounted) {
                                    Navigator.pop(context);
                                    ScaffoldMessenger.of(
                                      context
                                    ).showSnackBar(
                                      ExceptionSnackBar(
                                        message:
                                            "Evento excluído com sucesso!"
                                      ),
                                    );
                                  }

                                  setState(() {
                                    mainProvider.events
                                        .removeAt(widget.event.id as int);
                                  });
                                } catch (e) {
                                  Logger().w(
                                      "EventCard: erro ao excluit evanto - $e");
                                }
                              },
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
                  )
                : null;
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
