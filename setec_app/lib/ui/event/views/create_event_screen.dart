import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:setec_app/model/models/event/event.dart';
import 'package:setec_app/ui/event/viewModel/event_view_model.dart';
import 'package:setec_app/ui/utils/widgets/Text/Field/date_text_field.dart';

class CreateEvent extends ConsumerStatefulWidget {
  const CreateEvent({super.key});

  @override
  ConsumerState<CreateEvent> createState() => _CreateEventState();
}

class _CreateEventState extends ConsumerState<CreateEvent> {
  //Global Form Key
  final _globalKey = GlobalKey<FormState>();

  //Text Controlers
  final _descriptionController = TextEditingController();
  final _initialDate = TextEditingController();
  final _finalDate = TextEditingController();

  //DateTimes
  DateTime? initialDateTime;
  DateTime? finalDateTime;

  @override
  void dispose() {
    super.dispose();
    _descriptionController.dispose();
    _initialDate.dispose();
    _finalDate.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final eventState = ref.watch(eventViewModel);
    final eventVM = ref.watch(eventViewModel.notifier);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Criar Evento",
          style: GoogleFonts.lato(
            color: Colors.deepPurple,
          ),
        ),
      ),
      body: Center(
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
                validator: (value) => eventVM.isValidField(value),
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
                  backgroundColor: eventState is AsyncLoading
                      ? Colors.deepPurple.shade50
                      : Colors.deepPurple,
                ),
                onPressed: () {
                  if (_globalKey.currentState!.validate()) {
                    eventVM.createEvent(
                        context,
                        Event(
                          name: _descriptionController.text,
                          initialDateTime: initialDateTime!,
                          finalDateTime: finalDateTime!,
                        ));
                  }
                },
                child: eventState is AsyncLoading
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
