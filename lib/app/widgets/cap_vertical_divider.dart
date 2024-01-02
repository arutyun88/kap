import 'package:flutter/material.dart';

class CapVerticalDivider extends StatelessWidget {
  const CapVerticalDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Container(height: 24, width: 1, color: Theme.of(context).dividerColor),
    );
  }
}
