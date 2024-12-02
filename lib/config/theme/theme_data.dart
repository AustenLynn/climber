
import 'package:flutter/material.dart';

ThemeData lightMode = ThemeData(
    brightness: Brightness.light,
    textTheme: const TextTheme(
    headlineLarge: TextStyle(fontSize: 72, fontWeight: FontWeight.bold, color: Color(0xFF5c6467)),

      bodySmall: TextStyle(fontSize: 18, color: Color(0xFF5c6467) )



    ),
    colorScheme: const ColorScheme.light(
        primary: Color(0xFF2b95c6),
        surface: Color(0xffcbeaef),
        secondary: Color(0xFF166999),
        tertiary: Color(0xffADCCD1),
    )
);
ThemeData darkMode = ThemeData(
    brightness: Brightness.dark,
    colorScheme: const ColorScheme.dark(
      surface: Color(0xFFf3f900),
      primary: Color(0xFFcbea00),
      secondary: Color(0xFF166900),
  )
);

