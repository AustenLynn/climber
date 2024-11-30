import 'package:flutter/material.dart';
import 'Screens/home_screen.dart';
import 'Screens/insights_screen.dart';
import 'Screens/to_do_screen.dart';

class ScreenManager extends StatefulWidget {
  const ScreenManager({super.key});

  @override
  State<ScreenManager> createState() => _ScreenManagerState();
}


class _ScreenManagerState extends State<ScreenManager> {

  int _currentIndex = 0;

  final List<Widget> _screens = [
    HomeScreen(),
    TodoScreen(),
    InsightsScreen(),

  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
