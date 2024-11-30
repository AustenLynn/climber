import 'package:climber/config/theme/theme_data.dart';
import 'package:flutter/material.dart';

import 'Screens/home_screen.dart';

class Climber extends StatelessWidget{
  const Climber({super.key});


  @override
  Widget build( BuildContext context ){
    return MaterialApp(
      home: const HomeScreen(),
      theme: lightMode,
      darkTheme: darkMode,
    );
  }
}