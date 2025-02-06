import 'package:flutter/material.dart';

final ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  primaryColor: Colors.deepPurple,
  appBarTheme: const AppBarTheme(
    titleTextStyle: TextStyle(
      color: Colors.deepPurple,
      fontSize: 24,
      fontWeight: FontWeight.w600,
    ),
    iconTheme: IconThemeData(color: Colors.deepPurple),
    centerTitle: true,
    elevation: 4,
  ),
);
