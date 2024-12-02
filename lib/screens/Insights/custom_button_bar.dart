import 'package:flutter/material.dart';

class CustomTabBar extends StatelessWidget {
  final List<String> tabs;
  final int selectedIndex;
  final Function(int) onTap;

  const CustomTabBar({
    super.key,
    required this.tabs,
    required this.selectedIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color:Theme.of(context).colorScheme.tertiary,
          borderRadius: BorderRadius.circular(8)
      ),
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
                      ? Theme.of(context).colorScheme.primary// Highlight selected tab
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(8), // Smooth corners
                ),
                child: Text(
                  tabs[index],
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: selectedIndex == index
                        ? Theme.of(context).colorScheme.surface // Selected text color
                        :Theme.of(context).colorScheme.primary , // Unselected text color
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


