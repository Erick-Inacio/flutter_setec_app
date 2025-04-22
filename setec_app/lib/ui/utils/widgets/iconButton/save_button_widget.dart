import 'package:flutter/material.dart';

class SaveButtonWidget extends StatelessWidget {
  const SaveButtonWidget({
    super.key,
    required this.parentContext,
    this.onPressed,
  });

  final BuildContext parentContext;

  final Function? onPressed;

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
