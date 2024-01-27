import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kap/domain/enums/verify_code_state.dart';
import 'package:kap/domain/exceptions/authorization_exception.dart';
import 'package:kap/repositories/authorization_repository.dart';

class AuthService extends GetxService {
  AuthService._(this.isAuthorized, this._authorizationRepository);

  static Future<void> init(AuthorizationRepository authorizationRepository) async {
    final bool authorized = await authorizationRepository.checkLocalAuthState();
    Get.put(AuthService._(authorized.obs, authorizationRepository)).stateListener();
  }

  static AuthService get to => Get.find<AuthService>();

  final Rx<bool> isAuthorized;
  final AuthorizationRepository _authorizationRepository;

  Future<void> sendVerificationCodeByPhoneNumber(
    String phoneNumber,
    BuildContext context, {
    required Function(String) whenSuccess,
    required Function(Exception) whenFailed,
  }) async {
    await _authorizationRepository.phoneVerification(
      phoneNumber.phoneForSaveCondition,
      whenSuccess: whenSuccess,
      whenFailed: whenFailed,
    );
  }

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
      return verifiedAsNewUser ? VerifyCodeState.verifiedNewUser : VerifyCodeState.verifiedOldUser;
    } on CodeException catch (_) {
      return VerifyCodeState.error;
    } on TimeoutException catch (_) {
      return VerifyCodeState.expired;
    }
  }

  void logOut() => isAuthorized.value = false;

  void stateListener() => isAuthorized.listen((state) => _authorizationRepository.setLocalAuthState(state));
}

extension _PhoneExtension on String {
  String get phoneForSaveCondition => replaceAll(' ', '').replaceAll('-', '');
}
