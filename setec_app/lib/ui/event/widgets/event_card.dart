import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:setec_app/core/classes/result_class.dart';
import 'package:setec_app/model/models/event.dart';
import 'package:setec_app/core/formatters/format_date_time.dart';
import 'package:setec_app/providers/auth_state_notifier.dart';
import 'package:setec_app/providers/event_provider.dart';
import 'package:setec_app/ui/utils/widgets/snackBar/exception_snack_bar.dart';

class EventCard extends ConsumerWidget {
  final Event event;
  final bool isFinalEvent;

  const EventCard({
    super.key,
    required this.event,
    this.isFinalEvent = false,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final auth = ref.watch(authProvider);
    return Column(
      children: [
        InkWell(
          onTap: () {},
          onLongPress: () {
            auth.isAdmin
                ? showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text(
                        'Opções',
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
                                final eventNot = await ref
                                    .read(eventNotifier.notifier)
                                    .deleteEvent(event.id as int);

                                switch (eventNot) {
                                  case Ok():
                                    break;
                                  case Error(error: final e):
                                    throw e;
                                }

                                if (context.mounted) {
                                  Navigator.pop(context);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    ExceptionSnackBar(
                                      message: "Evento excluído com sucesso!",
                                    ),
                                  );
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
                            )
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
                      event.name,
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
                            FormatDateTime.formatDate(
                              event.initialDateTime,
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
                            FormatDateTime.formatDate(
                              event.finalDateTime,
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
        isFinalEvent ? SizedBox(height: 12) : Container(),
      ],
    );
  }
}
