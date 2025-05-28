import 'package:flutter/material.dart';

class ArrowBackWidget extends StatelessWidget {
  const ArrowBackWidget({super.key, required this.context});

  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 0,
      left: 0,
      child: IconButton(
        icon: Icon(Icons.arrow_back, color: Colors.deepPurple),
        onPressed: () {
          Navigator.of(context).pop(); // Volta para a tela anterior
        },
      ),
    );
  }
}
