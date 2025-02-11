import 'package:flutter/material.dart';

class SaveButtom extends StatelessWidget {
  final BuildContext parentContext;

  const SaveButtom({
    super.key,
    required this.parentContext,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.save, color: Colors.deepPurple),
      onPressed: () async {
        if (parentContext.mounted && context.mounted) {
          
        }
      },
    );
  }
}
