import 'package:flutter/material.dart';

class SaveButtom extends StatelessWidget {
  final BuildContext parentContext;

  final Function? onSave;

  const SaveButtom({
    super.key,
    required this.parentContext,
    this.onSave,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.save, color: Colors.deepPurple),
      onPressed: () async {
        if (onSave != null) onSave!();
      },
    );
  }
}
