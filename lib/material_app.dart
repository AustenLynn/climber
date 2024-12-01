import 'package:climber/config/theme/theme_data.dart';
import 'package:climber/scaffold.dart';
import 'package:flutter/material.dart';

import 'Dao/database.dart';


class Climber extends StatelessWidget{
  final AppDatabase database;

  const Climber({required this.database, super.key});

  @override
  Widget build( BuildContext context ){
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ScreenManager(database: database),
      theme: lightMode,
      darkTheme: darkMode,
    );
  }

}