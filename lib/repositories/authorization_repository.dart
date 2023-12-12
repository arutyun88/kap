import 'package:kap/datasource/authorization/authorization_datasource.dart';
import 'package:kap/datasource/device/device_datasource.dart';
import 'package:kap/domain/exceptions/custom_exception.dart';

class AuthorizationRepository {
  final AuthorizationDatasource remoteAuthorizationDatasource;
  final DeviceDatasource deviceDatasource;

  const AuthorizationRepository({
    required this.remoteAuthorizationDatasource,
    required this.deviceDatasource,
  });

  Future<void> phoneVerification(
    String phoneNumber, {
    required Function(String) whenSuccess,
    required Function(Exception) whenFailed,
  }) async {
    try {
      final cDevice = await deviceDatasource.getDeviceByDeviceId();
      if (cDevice != null && cDevice.phoneNumber != phoneNumber) {
        throw const DeviceAlreadyUseException('AuthorizationRepository: phoneVerification: device already use');
      }
      await remoteAuthorizationDatasource.phoneVerification(phoneNumber, whenSuccess, whenFailed);
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> codeVerification({
    required String verificationId,
    required String smsCode,
    required String phoneNumber,
  }) async {
    try {
      final isNewUser = await remoteAuthorizationDatasource.verifyOtp(verificationId: verificationId, smsCode: smsCode);
      if (isNewUser) {
        await deviceDatasource.createDeviceFromPhoneNumber(phoneNumber);
      }
      return isNewUser;
    } catch (_) {
      rethrow;
    }
  }
}
