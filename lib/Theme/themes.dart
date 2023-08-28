// ignore_for_file: prefer_const_constructors, unused_field, prefer_final_fields

import 'package:flutter/material.dart';

class MyTheme {
  static Color canvasLightColor = Color(0x0038394e).withOpacity(1);
  static Color canvasDarkColor = Color.fromARGB(255, 15, 15, 15);
  static Color iconColor = Colors.white70;
  static Color selectedIconColor = Color.fromARGB(255, 255, 206, 8);
  static Color fontColor = Color.fromARGB(255, 230, 193, 46);
  static Color unselectedIconColor = Color.fromARGB(255, 155, 153, 144);
  static Color cardColor = Color.fromARGB(255, 236, 218, 57);
}

class MyLoginPageTheme {
  static ThemeData loginPageTheme(BuildContext context) => ThemeData(
      textSelectionTheme: TextSelectionThemeData(
      selectionColor: Color.fromARGB(255, 190, 130, 51),
      cursorColor: const Color.fromARGB(255, 202, 191, 73),
    )
  );
}
