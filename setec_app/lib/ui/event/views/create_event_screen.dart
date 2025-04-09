import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:setec_app/data/event/service/event_services.dart';
import 'package:setec_app/providers/session_provider.dart';
import 'package:setec_app/ui/utils/ui/widgets/Text/Field/date_text_field.dart';
import 'package:setec_app/ui/utils/ui/widgets/snackBar/exception_snack_bar.dart';

class CreateEvent extends StatefulWidget {
  const CreateEvent({super.key});

  @override
  State<CreateEvent> createState() => _CreateEventState();
}

class _CreateEventState extends State<CreateEvent> {
  //Global Form Key
  final _globalKey = GlobalKey<FormState>();

  //Text Controlers
  final _descriptionController = TextEditingController();
  final _initialDate = TextEditingController();
  final _finalDate = TextEditingController();

  //DateTimes
  DateTime? initialDateTime;
  DateTime? finalDateTime;

  //Loading
  bool isLoading = false;

  @override
  void dispose() {
    super.dispose();
    _descriptionController.dispose();
    _initialDate.dispose();
    _finalDate.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // final mainProvider = context.watch<MainProvider>();

    void createEvent() async {
      setState(() {
        isLoading = true;
      });
      // Event event = Event.empty();

      // event.description = _descriptionController.text;
      // event.initialDateTime = initialDateTime!;
      // event.finalDateTime = finalDateTime!;

      try {
        final eventServices = EventServices();

        // await eventServices.post(event);

        if (context.mounted) {
          // await mainProvider.fetchEvents(context: context);
        }

        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            ExceptionSnackBar(
              message: "Evento criado com sucesso!",
            ),
          );
          Navigator.pop(context);
        }
      } catch (e) {
        setState(() => isLoading = false);
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            ExceptionSnackBar(
              message: e.toString(),
            ),
          );
        }
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Criar Evento",
          style: GoogleFonts.lato(
            color: Colors.deepPurple,
          ),
        ),
      ),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Center(
              child: Form(
                key: _globalKey,
                child: ListView(
                  shrinkWrap: true,
                  padding: const EdgeInsets.all(16.0),
                  children: <Widget>[
                    TextFormField(
                      controller: _descriptionController,
                      decoration: const InputDecoration(
                        labelText: 'Nome do Evento',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor, insira uma descrição válida';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 16),
                    DateTextField(
                      context: context,
                      fieldName: 'Data Inicial',
                      controller: _initialDate,
                      onDateTimeSelected: ((dateTime) => setState(() {
                            initialDateTime = dateTime;
                          })),
                    ),
                    SizedBox(height: 16),
                    DateTextField(
                      context: context,
                      fieldName: 'Data Final',
                      controller: _finalDate,
                      onDateTimeSelected: ((dateTime) => setState(() {
                            finalDateTime = dateTime;
                          })),
                    ),
                    SizedBox(height: 16),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepPurple,
                      ),
                      onPressed: () {
                        setState(() {
                          isLoading = true;
                        });
                        if (_globalKey.currentState!.validate()) {
                          setState(() {
                            isLoading = true;
                          });
                          createEvent();
                        }
                      },
                      child: isLoading
                          ? CircularProgressIndicator()
                          : Text(
                              'Criar Evento',
                              style: GoogleFonts.lato(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                    )
                  ],
                ),
              ),
            ),
    );
  }
}
