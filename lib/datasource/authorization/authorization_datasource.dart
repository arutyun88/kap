abstract interface class AuthorizationDatasource {
  Future<void> phoneVerification(
    String phoneNumber,
    void Function(String) whenSuccess,
    void Function(Exception) whenFailed,
  );

  Future<bool> verifyOtp({
    required String verificationId,
    required String smsCode,
  });
}
