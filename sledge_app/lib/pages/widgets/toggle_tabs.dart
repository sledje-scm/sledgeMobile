import 'package:flutter/material.dart';

class ToggleTabs extends StatelessWidget {
  final List<String> tabs;
  final String selectedTab;
  final Function(String) onTabSelected;

  const ToggleTabs({required this.tabs, required this.selectedTab, required this.onTabSelected});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: tabs.map((tab) {
        final isSelected = tab == selectedTab;
        return GestureDetector(
          onTap: () => onTabSelected(tab),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            decoration: BoxDecoration(
              color: isSelected ? Colors.blueAccent : Colors.grey[300],
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              tab,
              style: TextStyle(color: isSelected ? Colors.white : Colors.black, fontSize: 16),
            ),
          ),
        );
      }).toList(),
    );
  }
}
