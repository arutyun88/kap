import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kap/domain/enums/verify_code_state.dart';
import 'package:kap/domain/exceptions/authorization_exception.dart';
import 'package:kap/repositories/authorization_repository.dart';

class AuthService extends GetxService {
  AuthService._(this.isAuthorized, this._authorizationRepository);

  static Future<void> init(AuthorizationRepository authorizationRepository) async {
    final bool authorized = await authorizationRepository.checkLocalAuthState();
    Get.put(AuthService._(authorized.obs, authorizationRepository));
  }

  static AuthService get to => Get.find<AuthService>();

  final Rx<bool> isAuthorized;
  final AuthorizationRepository _authorizationRepository;

  Future<VerifyCodeState> verifyPhoneCode(
    BuildContext context, {
    required String phoneNumber,
    required String verificationId,
    required String smsCode,
  }) async {
    try {
      final verifiedAsNewUser = await _authorizationRepository.codeVerification(
        verificationId: verificationId,
        smsCode: smsCode,
        phoneNumber: phoneNumber.phoneForSaveCondition,
      );
      isAuthorized.value = true;
      _authorizationRepository.setLocalAuthState(isAuthorized.value);
      return verifiedAsNewUser ? VerifyCodeState.verifiedNewUser : VerifyCodeState.verifiedOldUser;
    } on CodeException catch (_) {
      return VerifyCodeState.error;
    } on TimeoutException catch (_) {
      return VerifyCodeState.expired;
    }
  }
}

extension _PhoneExtension on String {
  String get phoneForSaveCondition => replaceAll(' ', '').replaceAll('-', '');
}
