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
      backgroundColor: AppColors.primaryColor,
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
              )
              ,
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
                      style: const TextStyle(
                        fontSize: 48,
                        color:AppColors.accentColor,
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

/*
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
*/

/*
SizedBox(
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
Row(
mainAxisAlignment: MainAxisAlignment.center,
children: [

SizedBox(
width: 100,
height: 100,
child: Text(
formatSeconds(seconds),
style: const TextStyle(
fontSize: 48,
fontWeight: FontWeight.bold,
color: AppColors.textColor,
),
),
),
TimerButton(
onClicked: startTimer,
),
],
),

],
),
),
);
*/