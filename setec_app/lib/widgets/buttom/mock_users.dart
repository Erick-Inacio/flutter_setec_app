import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MockUsers extends StatelessWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;

  const MockUsers({
    super.key,
    required this.emailController,
    required this.passwordController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ElevatedButton(
          onPressed: () {
            emailController.text = "erick.de.faria@hotmail.com";
            passwordController.text = "123456";
          },
          child: Text(
            "Mock Admin",
            style: GoogleFonts.lato(
              color: Colors.white,
            ),
          ),
        ),
        ElevatedButton(
          onPressed: () {
            emailController.text = "teste1@student.com";
            passwordController.text = "123456";
          },
          child: Text(
            "Mock Student",
            style: GoogleFonts.lato(
              color: Colors.white,
            ),
          ),
        ),
        ElevatedButton(
          onPressed: () {
            emailController.text = "teste1@speaker.com";
            passwordController.text = "123456";
          },
          child: Text(
            "Mock Speaker",
            style: GoogleFonts.lato(
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}
