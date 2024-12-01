
import 'package:flutter/material.dart';


class TimerButton extends StatelessWidget {
  final VoidCallback onClicked;
  const TimerButton({super.key, required this.onClicked});

  @override
  Widget build(BuildContext context) => ElevatedButton(
    onPressed: onClicked,
    style: ElevatedButton.styleFrom(
      backgroundColor: Theme.of(context).colorScheme.primary
    ),
    child: const Text(
      "Start timer",
      style: TextStyle(color: Color(0xFF5c6467)),
    ),
  );
}
