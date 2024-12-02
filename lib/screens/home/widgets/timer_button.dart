
import 'package:flutter/material.dart';


class TimerButton extends StatelessWidget {
  final VoidCallback onClicked;
  const TimerButton({super.key, required this.onClicked});

  @override
  Widget build(BuildContext context) => ElevatedButton(
    onPressed: onClicked,
    style: ElevatedButton.styleFrom(
      backgroundColor: Theme.of(context).colorScheme.primary,
      elevation: 16
    ),
    child: Text(
      "Start Climb",
      style: TextStyle(color: Theme.of(context).colorScheme.surface),
    ),
  );
}
