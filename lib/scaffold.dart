import 'dart:math';

import 'package:climber/screens/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'Dao/database.dart';
import 'Dao/session.dart';
import 'Screens/Insights/insights_screen.dart';
import 'Screens/todo/to_do_screen.dart';

class ScreenManager extends StatefulWidget {
  final AppDatabase database;

  const ScreenManager({required this.database, super.key});
  @override
  State<ScreenManager> createState() => _ScreenManagerState();
}


class _ScreenManagerState extends State<ScreenManager> {
  int _currentIndex = 0;
  late List<Widget> _screens; // Declare but don't initialize here

  @override
  void initState() {
    super.initState();
    _screens = [
      MyHomeScreen(database: widget.database), // Now `widget.database` is accessible
      TodoScreen(),
      InsightsScreen(database: widget.database),
    ];
    //generateRandomSessions(100);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:  Theme.of(context).colorScheme.surface,
      body: IndexedStack(
        index: _currentIndex,
        children: _screens,
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }
  Widget _buildBottomNavigationBar(){
    return BottomNavigationBar(
      onTap: _changeIndex,
      currentIndex: _currentIndex,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.av_timer),
          label: 'Timer',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.checklist),
          label: 'To-Do',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.insights),
          label: 'Insights',
        ),
      ],
    );
  }

  _changeIndex(int index) {
    setState(() {
      _currentIndex = index;
    });
  }


  void  generateRandomSessions(int count) async {
    final random = Random();

    for (int i = 0; i < count; i++) {
      // Generate a random date within the year 2024
      const int year = 2024;
      final int month = random.nextInt(12) + 1; // Months are 1-12
      final int day = random.nextInt(DateTime(year, month + 1, 0).day) + 1; // Days of the month
      final int hour = random.nextInt(24); // Hours are 0-23
      final int minute = random.nextInt(60); // Minutes are 0-59

      final dateTime = DateTime(year, month, day, hour, minute);

      // Generate random session ID and duration
      final id = i + 1; // Example ID (sequential)
      final minutes = random.nextInt(170) +
          1; // Random duration (1-120 minutes)

      // Create a Session and add to the list
      await widget.database.sessionDao.insertSession(Session(id, minutes, dateTime.millisecondsSinceEpoch));
    }
  }
  }
