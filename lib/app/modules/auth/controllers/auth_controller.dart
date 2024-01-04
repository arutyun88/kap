import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_libphonenumber/flutter_libphonenumber.dart';
import 'package:get/get.dart';
import 'package:kap/router/app_router.dart';
import 'package:kap/services/auth_service.dart';
import 'package:kap/services/settings/localization_service.dart';

class AuthController extends GetxController {
  AuthController(this.context);

  final BuildContext context;

  final TextEditingController textController = TextEditingController();
  final countryRes = CountryManager()
      .countries
      .firstWhere((element) => element.countryCode == LocalizationService.locale.value.countryCode)
      .obs;
  final verificationId = ''.obs;

  final FocusNode fieldFocus = FocusNode();

  void onTapToSend() async {
    final phone = formatNumberSync(
      countryRes.value.phoneCode + textController.text,
      removeCountryCodeFromResult: false,
      phoneNumberFormat: PhoneNumberFormat.international,
    ).replaceAll(' ', '');
    await Get.find<AuthService>().sendVerificationCodeByPhoneNumber(
      phone,
      context,
      whenSuccess: (verificationId) async {
        print(verificationId);
        //     await Get.find<AuthService>().verifyPhoneCode(
        //       phoneNumber: textController.text,
        //       verificationId: verificationId,
        //       smsCode: '123456',
        //     );
        //     if (context.mounted) {
        //       Navigator.of(context).pop(verificationId);
        //     }
      },
    );
  }

  void onTapToChange() {
    context.router.push(const CountryRoute()).then(
      (value) {
        if (value is CountryWithPhoneCode) {
          textController.text = '';
          countryRes.value = value;

          fieldFocus.requestFocus();
        }
      },
    );
  }
}
