import 'package:flutter/material.dart';

ThemeData lightMode = ThemeData(
  brightness: Brightness.light,
  colorScheme: ColorScheme.light(
    surface: Colors.grey.shade300,
    // surface: Colors.green,
    // primary: Colors.grey.shade200,
    primary: Colors.black38,
    secondary: Colors.grey.shade400,
    // secondary: Colors.pink,
    // inversePrimary: Colors.grey.shade800,
  ),
  textTheme: ThemeData.light()
      .textTheme
      .apply(bodyColor: Colors.grey[800], displayColor: Colors.black),
);
