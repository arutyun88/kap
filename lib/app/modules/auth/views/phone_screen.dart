import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kap/app/modules/auth/controllers/auth_controller.dart';
import 'package:kap/app/widgets/cap_phone_field.dart';
import 'package:kap/config/l10n/custom_app_localizations.dart';

class PhoneScreen extends GetView<AuthController> {
  const PhoneScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        children: [
          Text(context.dictionary.authorizationNeed, style: Theme.of(context).textTheme.bodyLarge),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 24.0),
            child: Obx(
              () => CapPhoneField(
                country: controller.selectedCountry.value,
                onTap: controller.onTapToCountry,
                controller: controller.phoneController,
                focus: controller.phoneFieldFocus,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 24.0),
            child: Text(context.dictionary.authorizationDescription, style: Theme.of(context).textTheme.bodyLarge),
          ),
          Obx(
            () => OutlinedButton(
              onPressed: controller.sendButtonIsEnable.value ? controller.onTapToReceiveVerificationCode : null,
              child: Text(
                context.dictionary.authorizationCode,
                style: context.textTheme.bodyMedium,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
