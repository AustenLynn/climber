import 'package:climber/config/theme/theme_data.dart';
import 'package:climber/scaffold.dart';
import 'package:flutter/material.dart';


class Climber extends StatelessWidget{
  const Climber({super.key});

  @override
  Widget build( BuildContext context ){
    return MaterialApp(
      home: const ScreenManager(),
      theme: lightMode,
      darkTheme: darkMode,
    );
  }

}