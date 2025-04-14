import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class WillPalestrateWidget extends StatelessWidget {
  final bool value;
  final ValueChanged<bool> onChanged;

  const WillPalestrateWidget({
    super.key,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(4.0),
        border: Border.all(color: Colors.deepPurple, width: 1.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Text(
              'Irá palestrar?',
              style: GoogleFonts.lato(
                color: Colors.deepPurple,
                fontSize: 20,
              ),
            ),
            const Spacer(),
            Switch(
              value: value,
              onChanged: onChanged,
              inactiveThumbColor: Colors.deepPurple,
              activeColor: Colors.deepPurple,
              inactiveTrackColor: Colors.deepPurple.shade50,
            ),
          ],
        ),
      ),
    );
  }
}
