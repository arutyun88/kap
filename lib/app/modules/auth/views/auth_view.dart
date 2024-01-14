import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kap/app/modules/auth/controllers/auth_controller.dart';
import 'package:kap/app/modules/auth/views/code_screen.dart';
import 'package:kap/app/modules/auth/views/phone_screen.dart';
import 'package:kap/app/widgets/app_bottom_sheet.dart';
import 'package:kap/config/l10n/custom_app_localizations.dart';

class AuthView extends StatelessWidget {
  const AuthView._();

  static Future<void> show(BuildContext context) async => await AppBottomSheet.show(
        context,
        child: const AuthView._(),
        title: context.dictionary.authorizationTitle,
      ).then((value) => log('AuthView.show returned: ${value.toString()}'));

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: AuthController(context),
      builder: (controller) {
        return Obx(
          () => AnimatedSwitcher(
            duration: const Duration(milliseconds: 500),
            transitionBuilder: (child, animation) => FadeTransition(opacity: animation, child: child),
            child: controller.verificationId.value.isNotEmpty ? const CodeScreen() : const PhoneScreen(),
          ),
        );
      },
    );
  }
}
