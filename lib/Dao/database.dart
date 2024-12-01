// database.dart

// required package imports
import 'dart:async';
import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

import 'session_dao.dart';
import 'session.dart';

part 'database.g.dart'; // the generated code will be there

@Database(version: 1, entities: [Session])
abstract class AppDatabase extends FloorDatabase {
  SessionDao get sessionDao;
}