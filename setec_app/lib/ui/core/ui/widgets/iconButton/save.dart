import 'package:flutter/material.dart';

class SaveButtom extends StatelessWidget {
  final BuildContext parentContext;

  final Function? onPressed;

  const SaveButtom({
    super.key,
    required this.parentContext,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.save, color: Colors.deepPurple),
      onPressed: () async {
        if (parentContext.mounted && context.mounted && onPressed != null) {
          await onPressed!();
        }
      },
    );
  }
}
