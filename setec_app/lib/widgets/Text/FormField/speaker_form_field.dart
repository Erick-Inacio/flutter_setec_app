import 'package:flutter/material.dart';
import 'package:setec_app/models/user_app_model.dart';

class FormSpeakerField extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController company;
  final TextEditingController position;
  final TextEditingController bio;
  final Function(bool) onChanged;

  const FormSpeakerField({
    super.key,
    required this.formKey,
    required this.onChanged,
    required UserApp userApp,
    required this.company,
    required this.position,
    required this.bio,
  });

  @override
  State<FormSpeakerField> createState() => _FormSpeakerFieldState();
}

class _FormSpeakerFieldState extends State<FormSpeakerField> {
  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          elevation: 10,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: <Widget>[
                TextFormField(
                  controller: widget.company,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Empresa aonde trabalha (opcional)',
                    labelStyle: const TextStyle(color: Colors.deepPurple),
                  ),
                  onChanged: (value) => widget.onChanged(value.isNotEmpty),
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  controller: widget.position,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Cargo',
                    labelStyle: const TextStyle(color: Colors.deepPurple),
                  ),
                  onChanged: (value) => widget.onChanged(value.isNotEmpty),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, insira um cargo válido';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  controller: widget.bio,
                  maxLines: null,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Biografia',
                    labelStyle: const TextStyle(color: Colors.deepPurple),
                  ),
                  onChanged: (value) => widget.onChanged(value.isNotEmpty),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, insira uma biografia válida';
                    }
                    return null;
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
