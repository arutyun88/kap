import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppBottomNavigationBarItem extends StatelessWidget {
  const AppBottomNavigationBarItem({
    Key? key,
    required this.onTap,
    required this.selectedIndex,
    required this.index,
    required this.icon,
  }) : super(key: key);

  final VoidCallback onTap;
  final int selectedIndex;
  final int index;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final selectedItemColor = context.theme.bottomNavigationBarTheme.selectedItemColor;
    final unselectedItemColor = context.theme.bottomNavigationBarTheme.unselectedItemColor;

    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Icon(icon, color: selectedIndex == index ? selectedItemColor : unselectedItemColor, size: 24.0),
        ),
      ),
    );
  }
}
