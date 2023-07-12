import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
      scaffoldBackgroundColor: Colors.white,
      primaryColor: const Color(0xFF7a8dc7),
      cardColor: Colors.white,
      textTheme: const TextTheme(
          headlineLarge: TextStyle(
              fontSize: 22, fontWeight: FontWeight.w600, color: Colors.black),
          titleLarge: TextStyle(
              fontSize: 20.0, color: Colors.black, fontWeight: FontWeight.bold),
          labelMedium: TextStyle(
              color: Colors.black, fontSize: 18.0, fontWeight: FontWeight.bold),
          labelSmall: TextStyle(color: Colors.black, fontSize: 18.0),
          bodyLarge: TextStyle(fontSize: 20.0, color: Colors.black),
          bodyMedium: TextStyle(fontSize: 16.0, color: Colors.black)));
  static ThemeData darkTheme = ThemeData(
      primaryColor: Colors.deepPurpleAccent,
      scaffoldBackgroundColor: Colors.black38,
      cardColor: Colors.black,
      textTheme: const TextTheme(
          headlineLarge: TextStyle(
              fontSize: 22, fontWeight: FontWeight.w600, color: Colors.white),
          titleLarge: TextStyle(
              fontSize: 20.0, color: Colors.grey, fontWeight: FontWeight.bold),
          labelMedium: TextStyle(
              color: Colors.grey, fontSize: 18.0, fontWeight: FontWeight.bold),
          labelSmall: TextStyle(color: Colors.white, fontSize: 18.0),
          bodyLarge: TextStyle(fontSize: 20.0, color: Colors.white),
          bodyMedium: TextStyle(fontSize: 16.0, color: Colors.white)));
}
