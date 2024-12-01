import 'dart:async';
import 'package:flutter/material.dart';
import '../../Dao/database.dart';
import '../../Dao/session.dart';
import 'widgets/timer_button.dart';
import 'widgets/circular_slider.dart';

class MyHomeScreen extends StatefulWidget {
  final AppDatabase database;

  const MyHomeScreen({required this.database, super.key});


  @override
  MyHomeScreenState createState() => MyHomeScreenState();
}

class MyHomeScreenState extends State<MyHomeScreen> {
  double timeValue = 0;
  Timer? timer;
  int seconds = 0;
  int initialSeconds = 0; // Store the timer's starting value
  List<Session> sessions = [];

  // Fetch data from the database
  Future<void> _loadSessions() async {
    final sessionList = await widget.database.sessionDao.findAllSessions();
    setState(() {
      sessions = sessionList; // Update the UI with the data
    });
  }

  @override
  void initState() {
    super.initState();
    _loadSessions(); // Fetch data when the widget is initialized
  }

  @override
  Widget build(BuildContext context) {
    return _buildHomeScreen();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  Widget _buildHomeScreen() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: MediaQuery
              .of(context)
              .size
              .width,
          height: 400,
          child: Container(
            alignment: Alignment.center,
            child: Stack(
              alignment: Alignment.center,
                children: [
                  Container(
                    width: MediaQuery
                        .of(context)
                        .size
                        .width,
                    padding: EdgeInsets.fromLTRB(10, 15, 10, 40),
                    child: ClipOval(
                      child: Image.asset('assets/my_mountain.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Container(
                    width: 380,
                    child: CircularSlider(
                        onChanged: updateTimeValue, pointerValue: timeValue),
                  )
                ]
            ),
          ),
        ),
        SizedBox(
          width: MediaQuery
              .of(context)
              .size
              .width,
          height: 200,
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.all(MediaQuery
                      .of(context)
                      .size
                      .width * 0.02),
                  child: Text(
                    formatSeconds(seconds),
                    style: Theme.of(context).textTheme.headlineLarge,
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

  void updateTimeValue(double newValue) {
    setState(() {
      timeValue = newValue;
      seconds = (timeValue.floor() * 5 * 60);
    });
  }

  void startTimer() {
    if (timer != null && timer!.isActive) return;
    initialSeconds = seconds;

    timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (seconds > 0) {
        setState(() {
          seconds--;
        });
      } else {
        timer?.cancel();
        _registerTimer();
      }
    });
  }

  String formatSeconds(int seconds) {
    final int minutes = seconds ~/ 60;
    final int remainingSeconds = seconds % 60;
    return '$minutes:${remainingSeconds.toString().padLeft(2, '0')}';
  }


  void _registerTimer() async {
    final int elapsedMinutes = (initialSeconds - seconds) ~/ 60;

    final newSession = Session(
      sessions.length + 1,
      elapsedMinutes,
      DateTime.now().millisecondsSinceEpoch
    );

    await widget.database.sessionDao.insertSession(newSession);

    _loadSessions();
  }
}

