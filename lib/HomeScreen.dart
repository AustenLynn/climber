import 'dart:async';
import 'package:flutter/material.dart';
import 'TimerButton.dart';
import 'theme/Colors.dart';
import 'CircularSlider.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  double timeValue = 0;
  Timer? timer;
  int seconds = 0;

  void updateTimeValue(double newValue) {
    setState(() {
      timeValue = newValue;
      seconds = (timeValue.floor() * 60); // Converts to total seconds
    });
  }

  void startTimer() {
    if (timer != null && timer!.isActive) return; // Prevent multiple timers
    timer = Timer.periodic(Duration(seconds: 1), (_) {
      if (seconds > 0) {
        setState(() {
          seconds--;
        });
      } else {
        timer?.cancel(); // Stop the timer when it reaches zero
      }
    });
  }

  String displayTimeValue(double timeValue) {
    double minCount = timeValue.floor() * 5;
    return '${minCount.floor()}:00';
  }

  String formatSeconds(int seconds) {
    final int minutes = seconds ~/ 60;
    final int remainingSeconds = seconds % 60;
    return '$minutes:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        print("Image button inside circular slider tapped!");
                      },
                      child: ClipOval(
                        child: Image.asset(
                          'assets/my_mountain.png',
                          width: 250,
                          height: 250,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    CircularSlider(
                      onChanged: updateTimeValue,
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              formatSeconds(seconds),
              style: const TextStyle(
                fontSize: 48,
                fontWeight: FontWeight.bold,
                color: AppColors.textColor,
              ),
            ),
            SizedBox(height: 20),
            TimerButton(
              onClicked: startTimer,
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }
}

