// entity/person.dart

import 'package:floor/floor.dart';

@entity
class Session {

  @primaryKey
  final int id;
  final int minutes;
  // Store DateTime as an integer (timestamp)
  final int dateTimeMillis;

  Session(this.id, this.minutes, this.dateTimeMillis);

  // Convenience method to get DateTime
  DateTime get dateTime => DateTime.fromMillisecondsSinceEpoch(dateTimeMillis);

  // Factory to create Session from a DateTime
  factory Session.fromDateTime(int id, int minutes, DateTime dateTime) {
    return Session(id, minutes, dateTime.millisecondsSinceEpoch);
  }
}