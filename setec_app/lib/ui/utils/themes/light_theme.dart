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
  cardTheme: CardThemeData(
    color: Colors.deepPurple.shade50,
    elevation: 6,
  ),

  bottomAppBarTheme: BottomAppBarTheme(
    // color: Colors.deepPurple.shade100,
    elevation: 4,
  ),

  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    elevation: 4,
    selectedItemColor: Colors.deepPurple,
    unselectedItemColor: Colors.deepPurpleAccent,
  ),
);
