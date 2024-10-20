import 'package:flutter/material.dart';

final appTheme =  ThemeData(
  useMaterial3: true,
  scaffoldBackgroundColor: Colors.black45,
  textTheme: const TextTheme(
    titleLarge: TextStyle(
        fontSize: 25,
        color: Colors.blue,
        letterSpacing: 1.1
    ),
    titleMedium: TextStyle(
      fontSize: 20,
      letterSpacing: 1.0,
      color: Colors.blue,
    ),
    titleSmall: TextStyle(
      fontSize: 18,
      color: Colors.black,
    ),
    bodyLarge: TextStyle(
      fontSize: 18,
      color: Colors.black,
    ),
    bodyMedium: TextStyle(
        fontSize: 16.0,
        color: Colors.white,
    ),
    //List tile
    bodySmall: TextStyle(
        fontSize: 14.0,
        color: Colors.white,
    ),
  ),
  listTileTheme: ListTileThemeData(
    textColor: Colors.white,
    iconColor: Colors.white,
    tileColor: Colors.black45,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    ),
  ),

);