import 'package:flutter/material.dart';

class CustomColor{
  static const white = MaterialColor(
    0xFFFFFFFF,
    <int, Color>{
      50: Color(0xFFFFFFFF),
      100: Color(0xFFFFFFFF),
      200: Color(0xFFFFFFFF),
      300: Color(0xFFFFFFFF),
      400: Color(0xFFFFFFFF),
      500: Color(0xFFFFFFFF),
      600: Color(0xFFFFFFFF),
      700: Color(0xFFFFFFFF),
      800: Color(0xFFFFFFFF),
      900: Color(0xFFFFFFFF),
    },
  );

  static const black = MaterialColor(
    0xFF333333,
    <int, Color>{
      50: Color(0xFF333333),
      100: Color(0xFF333333),
      200: Color(0xFF333333),
      300: Color(0xFF333333),
      400: Color(0xFF333333),
      500: Color(0xFF333333),
      600: Color(0xFF333333),
      700: Color(0xFF333333),
      800: Color(0xFF333333),
      900: Color(0xFF333333),
    },
  );
}

bool isDarkMode = ThemeMode == (ThemeMode.dark) ? true : false;

void toggleTheme() {
  isDarkMode = !isDarkMode;
}

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    primarySwatch: Colors.blue,
    brightness: Brightness.light,
  );

  static ThemeData darkTheme = ThemeData(
    primarySwatch: CustomColor.black,
    brightness: Brightness.dark
  );
}
