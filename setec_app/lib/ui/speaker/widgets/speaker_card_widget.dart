import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class SpeakerCardWidget extends StatelessWidget {
  const SpeakerCardWidget({super.key, required this.user, required this.width});

  final double width;
  final dynamic user;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => context.push('/speakerProfile', extra: user),
      child: Card(
        margin: const EdgeInsets.all(8.0),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        child: ListTile(
          leading: CircleAvatar(
            radius: width / 12,
            backgroundColor: Colors.deepPurple,
            child: Icon(Icons.person, color: Colors.white),
          ),
          title: Text(user.user.name, style: GoogleFonts.lato()),
          subtitle: Text(user.user.email, style: GoogleFonts.lato()),
          // trailing:
        ),
      ),
    );
  }
}
