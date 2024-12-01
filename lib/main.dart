import 'package:flutter/material.dart';

import 'Dao/database.dart';
import 'material_app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Initialize Flutter bindings
  final database = await $FloorAppDatabase
      .databaseBuilder('app_database.db')
      .build();
  runApp(Climber(database: database));
}

