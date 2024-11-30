import 'dart:async';
import 'package:flutter/material.dart';
import '../widgets/timer_button.dart';
import '../widgets/circular_slider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  double timeValue = 0;
  Timer? timer;
  int seconds = 0;

  void updateTimeValue(double newValue) {
    setState(() {
      timeValue = newValue;
      seconds = (timeValue.floor() * 5 * 60);
    });
  }

  void startTimer() {
    if (timer != null && timer!.isActive) return;
    timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (seconds > 0) {
        setState(() {
          seconds--;
        });
      } else {
        timer?.cancel();
        // RegisterTimer()
      }
    });
  }

  String formatSeconds(int seconds) {
    final int minutes = seconds ~/ 60;
    final int remainingSeconds = seconds % 60;
    return '$minutes:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: _buildHomeScreen(),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  Widget _buildBottomNavigationBar(){
    return BottomNavigationBar(
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
  Widget _buildHomeScreen(){
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height:400,
            child: Container(
              color: Colors.red,
              child: Stack(
                children: [
                  CircularSlider(onChanged: updateTimeValue, pointerValue: timeValue)
                ]
              ),
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height:200,
            child: Container(
              color: Colors.blue,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.all(MediaQuery.of(context).size.width * 0.02),
                    child: Text(
                      formatSeconds(seconds),
                      style: TextStyle(
                        fontSize: 48,
                        color: Theme.of(context).colorScheme.surface,
                      ) ,
                    ),
                  ),
                  TimerButton(onClicked: startTimer)
                ],
              ),
            ),
          ),

        ],
      );
  }
}

