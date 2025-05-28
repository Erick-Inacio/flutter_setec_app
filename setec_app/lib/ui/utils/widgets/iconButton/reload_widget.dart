import 'package:flutter/material.dart';

class ReloadWidget extends StatelessWidget {
  const ReloadWidget({super.key, required this.onPressed});

  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () {
          onPressed();
        },
        icon: const Icon(Icons.refresh));
  }
}
