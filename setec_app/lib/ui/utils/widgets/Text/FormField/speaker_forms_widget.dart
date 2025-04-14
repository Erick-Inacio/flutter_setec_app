import 'package:flutter/material.dart';

class SpeakerFormsWidget extends StatefulWidget {
  // final GlobalKey<FormState> formKey;
  final TextEditingController company;
  final TextEditingController position;
  final TextEditingController bio;
  final Function(bool)? onChanged;
  final BuildContext parentContext;

  const SpeakerFormsWidget({
    super.key,
    required this.parentContext,
    // required this.formKey,
    this.onChanged,
    required this.company,
    required this.position,
    required this.bio,
  });

  @override
  State<SpeakerFormsWidget> createState() => _FormSpeakerFieldState();
}

class _FormSpeakerFieldState extends State<SpeakerFormsWidget> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      // padding: const EdgeInsets.all(16.0),
      child: Column(
        children: <Widget>[
          TextFormField(
            controller: widget.company,
            decoration: InputDecoration(
              labelText: 'Empresa aonde trabalha (opcional)',
              labelStyle: const TextStyle(color: Colors.deepPurple),
            ),
            onChanged: (value) {
              if (widget.onChanged != null) {
                widget.onChanged!(value.isNotEmpty);
              }
            },
          ),
          const SizedBox(height: 16.0),
    
          //Cargo
          TextFormField(
            controller: widget.position,
            decoration: InputDecoration(
              labelText: 'Cargo',
              labelStyle: const TextStyle(color: Colors.deepPurple),
            ),
            onChanged: (value) {
              if (widget.onChanged != null) {
                widget.onChanged!(value.isNotEmpty);
              }
            },
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor, insira um cargo válido';
              }
              return null;
            },
          ),
          const SizedBox(height: 16.0),
    
          //Biografia
          TextFormField(
            controller: widget.bio,
            maxLines: null,
            decoration: InputDecoration(
              labelText: 'Biografia',
              labelStyle: const TextStyle(color: Colors.deepPurple),
            ),
            onChanged: (value) {
              if (widget.onChanged != null) {
                widget.onChanged!(value.isNotEmpty);
              }
            },
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor, insira uma biografia válida';
              }
              return null;
            },
          )
        ],
      ),
    );
  }
}
