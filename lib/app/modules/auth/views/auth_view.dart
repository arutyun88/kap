import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kap/app/modules/auth/controllers/auth_controller.dart';
import 'package:kap/app/widgets/app_bottom_sheet.dart';
import 'package:kap/app/widgets/cap_phone_field.dart';
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
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            children: [
              Text(context.dictionary.authorizationNeed, style: Theme.of(context).textTheme.bodyLarge),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 24.0),
                child: Obx(
                  () => CapPhoneField(
                    country: controller.countryRes.value,
                    onTap: controller.onTapToChange,
                    controller: controller.textController,
                    focus: controller.fieldFocus,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 24.0),
                child: Text(context.dictionary.authorizationDescription, style: Theme.of(context).textTheme.bodyLarge),
              ),
              OutlinedButton(
                onPressed: controller.onTapToSend,
                child: Text(context.dictionary.authorizationCode, style: context.textTheme.bodyMedium),
              ),
            ],
          ),
        );
      },
    );
  }
}
