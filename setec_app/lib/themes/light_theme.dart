import 'package:flutter/material.dart';

// MaterialColor lightColors = MaterialColor(primary, swatch).deepPurple.shade50;


final ThemeData lightTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.light,
  primaryColor: Colors.deepPurple,

  //AppBar
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

  //InputDecoration
  inputDecorationTheme: const InputDecorationTheme(
    border: OutlineInputBorder(),
    fillColor: Colors.white,
    filled: true,
    focusedBorder: OutlineInputBorder(
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

  //ElevatedButtom
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: Colors.deepPurple,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
    ),
  ),

  //Card
  cardTheme: CardTheme(
    color: Colors.deepPurple.shade50,
    elevation: 6,
  ),
);
