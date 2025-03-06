import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:setec_app/models/user_app_model.dart';

class UserCard extends StatelessWidget {
  final UserApp? userApp;
  final VoidCallback? onTap;

  const UserCard({super.key, required this.userApp, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Card(
        margin: const EdgeInsets.all(8),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: ListTile(
          leading: const Icon(
            Icons.person,
            color: Colors.deepPurple,
          ),
          title:
              Text(userApp!.name, style: GoogleFonts.lato()),
          subtitle: Row(
            children: <Widget>[
            Text(userApp!.relationship.displayName, style: GoogleFonts.lato()),
          ]),
          trailing: Chip(
            label: Text(userApp!.role.displayName, style: TextStyle(color: Colors.white)),
            backgroundColor: Colors.deepPurple,
          ),
        ),
      ),
    );
  }
}
