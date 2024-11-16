
import 'package:climber/theme/Colors.dart';
import 'package:flutter/material.dart';

class TimerButton extends StatelessWidget {
  final VoidCallback onClicked;
  const TimerButton({super.key, required this.onClicked});

  @override
  Widget build(BuildContext context) => ElevatedButton(
    onPressed: onClicked,
    child: const Text(
      "Start timer",
      style: TextStyle(color: AppColors.textColor),
    ),
  );
}
