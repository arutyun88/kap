import 'package:flutter/material.dart';
import 'package:kap/config/palette/palette.dart';

class AppTextField extends StatelessWidget {
  const AppTextField({
    Key? key,
    this.focusNode,
    this.onTap,
    this.hintText,
  }) : super(key: key);

  final FocusNode? focusNode;
  final VoidCallback? onTap;
  final String? hintText;

  @override
  Widget build(BuildContext context) {
    return TextField(
      cursorColor: Palette.accent,
      decoration: InputDecoration(hintText: hintText),
      focusNode: focusNode,
      onTap: onTap,
      keyboardType: TextInputType.emailAddress,
    );
  }
}
