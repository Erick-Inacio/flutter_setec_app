import 'package:flutter/material.dart';

class CardCarousel extends StatelessWidget {
  const CardCarousel({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: const EdgeInsets.all(16.0),
        foregroundDecoration: BoxDecoration(
          border: Border.all(
            color: Colors.black,
            width: 2.0,
          ),
        ),
        child: const Text('Card content'),
      ),
    );
  }
}
