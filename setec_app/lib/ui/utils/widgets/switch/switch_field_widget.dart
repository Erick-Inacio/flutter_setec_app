import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SwitchFieldWidget extends StatelessWidget {
  const SwitchFieldWidget({
    super.key,
    required this.value,
    required this.onChanged,
    required this.text,
    this.isEditable = true,
    this.width = 0.0,
  });
  final bool value;
  final double width;
  final String text;
  final ValueChanged<bool> onChanged;
  final bool isEditable;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: width),
        child: Container(
          height: 56,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(4.0),
            border: Border.all(color: Colors.deepPurple, width: 1.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Align(
                    alignment:
                        isEditable ? Alignment.centerLeft : Alignment.center,
                    child: Text(
                      text,
                      style: GoogleFonts.lato(
                        color: Colors.deepPurple,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
                isEditable ? Spacer() : const SizedBox(),
                isEditable
                    ? Switch(
                        value: value,
                        onChanged: onChanged,
                        inactiveThumbColor: Colors.deepPurple,
                        activeColor: Colors.deepPurple,
                        inactiveTrackColor: Colors.deepPurple.shade50,
                      )
                    : SizedBox(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
