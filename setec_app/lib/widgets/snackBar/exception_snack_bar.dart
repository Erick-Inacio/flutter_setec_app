import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ExceptionSnackBar extends SnackBar {
  ExceptionSnackBar({
    super.key,
    // required this.parentContext,
    required String message,
    Function? onAction,
    String? actionText,
  }) : super(
          content: Text(
            message,
            style: GoogleFonts.lato(
              color: Colors.black,
              fontSize: 15,
            ),
          ),
          action: actionText != null && onAction != null
              ? SnackBarAction(
                  label: actionText,
                  textColor: Colors.redAccent,
                  onPressed: () async {
                    await onAction();
                  },
                )
              : null,
          backgroundColor: const Color.fromARGB(255, 255, 252, 86),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          margin: const EdgeInsets.all(8),
          duration: const Duration(seconds: 3),
        );
}
