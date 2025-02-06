import 'package:flutter/material.dart';

class InfoTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String? info;

  const InfoTextField({super.key, this.controller, this.info});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      readOnly: true,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(
            color: Colors.deepPurple,
            width: 2.0,
          ),
        ),
        labelText: info != null ? info! : '',
        labelStyle: const TextStyle(color: Colors.deepPurple),
      ),
    );
  }
}
