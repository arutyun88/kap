import 'package:flutter/material.dart';
import 'package:kap/config/palette/palette.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class AppTextField extends StatelessWidget {
  const AppTextField({
    Key? key,
    this.focusNode,
    this.onTap,
    this.hintText,
    this.keyboardType = TextInputType.text,
    required this.controller,
  }) : super(key: key);

  final FocusNode? focusNode;
  final VoidCallback? onTap;
  final String? hintText;
  final TextInputType keyboardType;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      inputFormatters: [
        MaskTextInputFormatter(
          mask: '+7 (###) ###-##-##',
          filter: {"#": RegExp(r'[0-9]')},
          type: MaskAutoCompletionType.eager,
        ),
      ],
      cursorColor: Palette.accent,
      decoration: InputDecoration(hintText: hintText),
      focusNode: focusNode,
      onTap: onTap,
      keyboardType: keyboardType,
    );
  }
}
