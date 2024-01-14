import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kap/app/modules/auth/controllers/auth_controller.dart';
import 'package:kap/app/widgets/code_field.dart';
import 'package:kap/config/l10n/custom_app_localizations.dart';

class CodeScreen extends GetView<AuthController> {
  const CodeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 24.0),
          child: CodeField(controller: controller.codeController),
        ),
        OutlinedButton(
          onPressed: controller.onTapToSendCode,
          child: Text(
            context.dictionary.authorizationCode,
            style: context.textTheme.bodyMedium,
          ),
        )
      ],
    );
  }
}
