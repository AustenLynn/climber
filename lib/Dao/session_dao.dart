// dao/person_dao.dart

import 'package:climber/Dao/session.dart';
import 'package:floor/floor.dart';

@dao
abstract class SessionDao {
  @Query('SELECT * FROM Session')
  Future<List<Session>> findAllSessions();

  @Query('''
  SELECT * FROM Session 
  WHERE dateTimeMillis >= :startMillis AND dateTimeMillis <= :endMillis
''')
  Future<List<Session>> findSessionsInRange(int startMillis, int endMillis);

  @Query('SELECT minutes FROM Session')
  Stream<List<int>> findAllSessionMinutes();

  @Query('SELECT * FROM Session WHERE id = :id')
  Stream<Session?> findSessionById(int id);

  @insert
  Future<void> insertSession(Session session);
}