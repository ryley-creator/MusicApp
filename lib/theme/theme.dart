import 'package:flutter/material.dart';

final lightTheme = ThemeData(
  brightness: Brightness.light,
  useMaterial3: true,
  primaryColor: Colors.white,
  scaffoldBackgroundColor: Colors.grey[100],
  canvasColor: Colors.grey[100],
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.white,
    foregroundColor: Colors.black87,
    elevation: 0,
    titleTextStyle: TextStyle(
      color: Colors.black87,
      fontSize: 20,
      fontWeight: FontWeight.w600,
    ),
    iconTheme: IconThemeData(color: Colors.black54),
  ),
  cardColor: Colors.white,
  dividerColor: Colors.grey[300],
  iconTheme: const IconThemeData(color: Colors.black54),
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: Colors.grey[800],
    foregroundColor: Colors.white,
  ),
  textTheme: TextTheme(
    bodyMedium: TextStyle(color: Colors.grey[800]),
    titleMedium: TextStyle(
      color: Colors.grey[900],
      fontWeight: FontWeight.w600,
    ),
  ),
  progressIndicatorTheme: ProgressIndicatorThemeData(color: Colors.grey[800]),
);

final darkTheme = ThemeData(
  brightness: Brightness.dark,
  useMaterial3: true,
  primaryColor: Colors.black,
  scaffoldBackgroundColor: Colors.black,
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.black,
    foregroundColor: Colors.white,
    elevation: 2,
  ),
  cardColor: Colors.black,
  dividerColor: Colors.black,
  iconTheme: const IconThemeData(color: Colors.deepPurpleAccent),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: Colors.deepPurpleAccent,
    foregroundColor: Colors.white,
  ),
  textTheme: const TextTheme(
    bodyMedium: TextStyle(color: Colors.white70),
    titleMedium: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
  ),
);
