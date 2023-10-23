import 'package:flutter/material.dart';

ThemeData darkMode = ThemeData(
  brightness: Brightness.dark,
  colorScheme: ColorScheme.dark(
    //background: Colors.grey.shade900,
    background: const Color(0xFF121212),
    primary: Colors.grey.shade900,
    secondary: Colors.lightBlue,
    inversePrimary: Colors.grey.shade300,
  ),
  textTheme: ThemeData.dark().textTheme.apply(
    bodyColor: Colors.grey.shade300,
    displayColor: Colors.white,
  ),
);