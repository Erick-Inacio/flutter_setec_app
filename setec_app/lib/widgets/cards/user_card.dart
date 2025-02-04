import 'package:flutter/material.dart';
import 'package:setec_app/models/user_app_model.dart';

class UserCard extends StatelessWidget {
  final UserApp? userApp;

  const UserCard({super.key, required this.userApp});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.all(8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: ListTile(
        leading: const Icon(
          Icons.person,
          color: Colors.deepPurple,
        ),
        title:
            Text(userApp!.name, style: TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(userApp!.email),
        trailing: Chip(
          label: Text(userApp!.role.name),
          backgroundColor: Colors.deepPurple,
        ),
      ),
    );
  }
}
