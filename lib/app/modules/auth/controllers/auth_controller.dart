import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_libphonenumber/flutter_libphonenumber.dart';
import 'package:get/get.dart';
import 'package:kap/domain/exceptions/authorization_exception.dart';
import 'package:kap/domain/exceptions/custom_exception.dart';
import 'package:kap/router/app_router.dart';
import 'package:kap/services/auth_service.dart';
import 'package:kap/services/settings/localization_service.dart';

class AuthController extends GetxController {
  AuthController(this.context);

  final BuildContext context;

  late final TextEditingController phoneController;
  late final TextEditingController codeController;
  late final FocusNode phoneFieldFocus;
  late final Rx<CountryWithPhoneCode> selectedCountry;
  late final RxBool sendButtonIsEnable;

  final verificationId = ''.obs;

  @override
  void onInit() {
    super.onInit();

    phoneController = TextEditingController();
    codeController = TextEditingController();
    phoneFieldFocus = FocusNode();
    selectedCountry = CountryManager()
        .countries
        .firstWhere((element) => element.countryCode == LocalizationService.locale.value.countryCode)
        .obs;
    sendButtonIsEnable = phoneController.text.isNotEmpty.obs;
    phoneController.addListener(_phoneFieldListener);
  }

  @override
  void dispose() {
    phoneController.removeListener(_phoneFieldListener);
    phoneController.dispose();
    super.dispose();
  }

  void _phoneFieldListener() => sendButtonIsEnable.value = phoneController.text.length ==
      selectedCountry.value.phoneMaskFixedLineInternational
          .substring(
            selectedCountry.value.phoneMaskFixedLineInternational.indexOf(' '),
            selectedCountry.value.phoneMaskFixedLineInternational.length,
          )
          .trim()
          .length;

  void onTapToCountry() => context.router.push(const CountryRoute()).then(
        (value) {
          if (value is CountryWithPhoneCode) {
            phoneController.text = '';
            selectedCountry.value = value;

            phoneFieldFocus.requestFocus();
          }
        },
      );

  void onTapToReceiveVerificationCode() async {
    final phone = formatNumberSync(
      selectedCountry.value.phoneCode + phoneController.text,
      removeCountryCodeFromResult: false,
      phoneNumberFormat: PhoneNumberFormat.international,
    );

    try {
      await Get.find<AuthService>().sendVerificationCodeByPhoneNumber(
        phone,
        context,
        whenSuccess: (newVerificationId) async => verificationId.value = newVerificationId,
        whenFailed: (exception) {
          if (exception is TooMachException) {
            _showDialog(exception.message);
          }
        },
      );
    } on DeviceAlreadyUseException catch (e) {
      _showDialog(e.message);
    }
  }

  void onTapToSendCode() async {
    final phone = formatNumberSync(
      selectedCountry.value.phoneCode + phoneController.text,
      removeCountryCodeFromResult: false,
      phoneNumberFormat: PhoneNumberFormat.international,
    ).replaceAll(' ', '').replaceAll('-', '');
    if (verificationId.value.isNotEmpty && codeController.text.length == 6) {
      await Get.find<AuthService>().verifyPhoneCode(
        phoneNumber: phone,
        verificationId: verificationId.value,
        smsCode: codeController.text,
      );
      if (context.mounted) {
        Navigator.of(context).pop(verificationId);
      }
    }
  }

  void _showDialog(String message) async {
    if (!context.mounted) return;
    await showDialog(
      context: context,
      builder: (context) {
        return Center(
          child: Container(
            margin: const EdgeInsets.all(16.0),
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              color: context.theme.scaffoldBackgroundColor,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(message, style: context.textTheme.bodyMedium),
                Padding(
                  padding: const EdgeInsets.only(top: 24.0),
                  child: OutlinedButton(onPressed: Navigator.of(context).pop, child: const Text('close')),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
