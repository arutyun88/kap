import 'package:kap/domain/models/user_auth_model/user_auth_model.dart';

abstract interface class AuthorizationDatasource {
  Future<void> phoneVerification(
    String phoneNumber,
    void Function(String) whenSuccess,
    void Function(Exception) whenFailed,
  );

  Future<UserAuthModel> verifyOtp({
    required String verificationId,
    required String smsCode,
  });
}
