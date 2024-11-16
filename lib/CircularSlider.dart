
import 'package:climber/theme/Colors.dart';
import 'package:flutter/material.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

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
        onChanged(value.floor() * 5 );  // Update the parent widget's state with the new value
      },
    );
  }
}