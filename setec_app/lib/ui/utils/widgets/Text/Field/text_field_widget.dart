import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextFieldWidget extends StatefulWidget {
  const TextFieldWidget({
    super.key,
    this.controller,
    required this.fieldName,
    this.enabled = true,  
  });
  final TextEditingController? controller;
  final String fieldName;
  final bool enabled;

  @override
  State<TextFieldWidget> createState() => _TextFieldWidgetState();
}

class _TextFieldWidgetState extends State<TextFieldWidget> {
  
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(
          height: 55,
          child: TextField(
           maxLength: null,
            controller: widget.controller,
            style: GoogleFonts.lato(fontSize: 18,
            
            color: Colors.deepPurple),
            // readOnly: true,
            enabled: widget.enabled,
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.0),
                borderSide: const BorderSide(
                  color: Colors.grey,
                  width: 1.0,
                ),
              ),
              labelText: widget.fieldName,
              labelStyle: GoogleFonts.lato(
                color: Colors.deepPurple,
                fontSize: 16,
              ),
            ),
          ),
        ),
        SizedBox(height: 10),
      ],
    );
  }
}
