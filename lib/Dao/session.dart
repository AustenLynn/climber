// entity/person.dart

import 'package:floor/floor.dart';

@entity
class Session {

  @primaryKey
  final int id;
  final int minutes;
  final int dateTimeMillis;

  Session(this.id, this.minutes, this.dateTimeMillis);

  DateTime get dateTime => DateTime.fromMillisecondsSinceEpoch(dateTimeMillis);

  factory Session.fromDateTime(int id, int minutes, DateTime dateTime) {
    return Session(id, minutes, dateTime.millisecondsSinceEpoch);
  }
}