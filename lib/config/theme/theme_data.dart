
import 'package:flutter/material.dart';

ThemeData lightMode = ThemeData(
    brightness: Brightness.light,
    colorScheme: const ColorScheme.light(
        surface: Color(0xFFf3f9f9),
        primary: Color(0xFFcbeaef),
        secondary: Color(0xFF166999),
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

