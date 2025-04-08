import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomButtom extends StatefulWidget {
  final Function? onPressed;
  final String text;

  const CustomButtom({
    super.key,
    this.onPressed,
    required this.text,
  });

  @override
  State<CustomButtom> createState() => _CustomButtomState();
}

class _CustomButtomState extends State<CustomButtom> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 16, 0, 40),
      child: ElevatedButton(
        onPressed: () async {
          if (widget.onPressed != null) {
            await widget.onPressed!();
          }
        },
        child: Text(
          widget.text,
          style: GoogleFonts.lato(
            color: Colors.white,
            fontSize: 15,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
