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
  // inputDecorationTheme: InputDecorationTheme(
  //   border: OutlineInputBorder(
  //     borderRadius: BorderRadius.circular(10.0),
  //     borderSide: const BorderSide(
  //       color: Colors.deepPurple,
  //       width: 2.0,
  //     ),
  //   ),
  //   outlineBorder: BorderSide(
  //     color: Colors.deepPurple,
  //     width: 2.0,
  //   ),
  // )
  inputDecorationTheme: const InputDecorationTheme(
    border: InputBorder.none,
    focusedBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: Colors.deepPurple),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: Colors.deepPurple,
      ),
    ),
    labelStyle: TextStyle(
      color: Colors.deepPurple,
      fontSize: 20,
    ),
  ),
);
