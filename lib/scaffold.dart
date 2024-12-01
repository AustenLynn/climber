import 'package:climber/screens/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'Dao/database.dart';
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
      InsightsScreen(),
    ];
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
}
