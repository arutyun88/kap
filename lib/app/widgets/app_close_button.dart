import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppCloseButton extends StatelessWidget {
  const AppCloseButton({
    Key? key,
    required this.onTap,
  }) : super(key: key);

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Icon(Icons.close, color: context.theme.bottomNavigationBarTheme.selectedItemColor, size: 24.0),
      ),
    );
  }
}
