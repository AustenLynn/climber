
import 'package:flutter/material.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';
import 'theme/Colors.dart';
class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  double timeValue = 0;

  void updateTimeValue(double newValue) {
    setState(() {
      timeValue = newValue;
    });
  }

  String displayTimeValue(double timeValue) {
    double minCount = timeValue.floor() * 5;
    return '${minCount.floor()}:00';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Stack(
              children: [
                Positioned(
                  child: GestureDetector(
                    onTap: () {
                      print("Image button inside circular slider tapped!");
                      // You can perform other actions here as well
                    },
                    child: ClipOval(
                      child:
                      Image.asset(
                        'assets/my_mountain.png', // Replace with your image asset path
                        width: 250, // Adjust the size as needed
                        height: 250,
                        fit: BoxFit.cover,
                      ),

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
            Text(
              displayTimeValue(timeValue),
              style: TextStyle(fontSize: 48,
              color: AppColors.textColor,
              ),
            )
            ]
          )

        ],
      ),
    );
  }

}

class CircularSlider extends StatelessWidget {
  final Function(double) onChanged;

  const CircularSlider({Key? key, required this.onChanged}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SleekCircularSlider(
      initialValue: 0,
      max: 36,
      appearance: CircularSliderAppearance(
        customColors: CustomSliderColors(
          progressBarColors: [Colors.red],
          trackColor: AppColors.secondaryColor,
          shadowColor: AppColors.accentColor,
          shadowMaxOpacity: 0.5,
        ),
        customWidths: CustomSliderWidths(
          progressBarWidth: 24,
          trackWidth: 24,
          shadowWidth: 20,
        ),
        size: 250,
        startAngle: 270,
        angleRange: 360,
        infoProperties: InfoProperties(
          mainLabelStyle: TextStyle(fontSize: 24, color: Colors.blue),
          modifier: (double value) {
            return '${value.toStringAsFixed(0)}%';
          },
        ),
        spinnerMode: false,
        animationEnabled: true,
      ),
      onChange: (double value) {
        onChanged(value);  // Update the parent widget's state with the new value
      },
    );
  }
}
