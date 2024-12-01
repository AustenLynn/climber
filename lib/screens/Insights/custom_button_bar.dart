import 'package:flutter/material.dart';

class CustomTabBar extends StatelessWidget {
  final List<String> tabs; // List of tab labels
  final int selectedIndex; // Currently selected tab index
  final Function(int) onTap; // Callback for tab taps

  const CustomTabBar({
    super.key,
    required this.tabs,
    required this.selectedIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color:Theme.of(context).colorScheme.tertiary, // Bar background color
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: List.generate(tabs.length, (index) {
          return Expanded(
            child: GestureDetector(
              onTap: () => onTap(index), // Pass the index to the callback
              child: Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  color: selectedIndex == index
                      ? Colors.blue // Highlight selected tab
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(8), // Smooth corners
                ),
                child: Text(
                  tabs[index],
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: selectedIndex == index
                        ? Colors.white // Selected text color
                        : Colors.blue, // Unselected text color
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}


