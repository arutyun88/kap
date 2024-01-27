import 'package:kap/datasource/authorization/authorization_datasource.dart';
import 'package:kap/datasource/authorization/local_authorization_datasource.dart';
import 'package:kap/datasource/device/device_datasource.dart';
import 'package:kap/datasource/user/user_datasource.dart';
import 'package:kap/domain/exceptions/custom_exception.dart';
import 'package:kap/domain/exceptions/user_exception.dart';

class AuthorizationRepository {
  final AuthorizationDatasource _remoteAuthorizationDatasource;
  final LocalAuthorizationDatasource _localAuthorizationDatasource;
  final DeviceDatasource _deviceDatasource;
  final UserDatasource _userDatasource;

  const AuthorizationRepository({
    required AuthorizationDatasource remoteAuthorizationDatasource,
    required LocalAuthorizationDatasource localAuthorizationDatasource,
    required DeviceDatasource deviceDatasource,
    required UserDatasource userDatasource,
  })  : _deviceDatasource = deviceDatasource,
        _localAuthorizationDatasource = localAuthorizationDatasource,
        _remoteAuthorizationDatasource = remoteAuthorizationDatasource,
        _userDatasource = userDatasource;

  Future<bool> checkLocalAuthState() async {
    try {
      return await _localAuthorizationDatasource.checkIsAuthorized();
    } catch (_) {
      rethrow;
    }
  }

  Future<void> setLocalAuthState(bool state) async {
    try {
      await _localAuthorizationDatasource.updateAuthorizedState(state);
    } catch (_) {
      rethrow;
    }
  }

  Future<void> phoneVerification(
    String phoneNumber, {
    required Function(String) whenSuccess,
    required Function(Exception) whenFailed,
  }) async {
    try {
      final cDevice = await _deviceDatasource.getDeviceByDeviceId();
      if (cDevice != null && cDevice.phoneNumber != phoneNumber) {
        throw const DeviceAlreadyUseException('AuthorizationRepository: phoneVerification: device already use');
      }
      await _remoteAuthorizationDatasource.phoneVerification(phoneNumber, whenSuccess, whenFailed);
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
      final userModel =
          await _remoteAuthorizationDatasource.verifyOtp(verificationId: verificationId, smsCode: smsCode);
      if (userModel.isNewUser) {
        await _deviceDatasource.createDeviceFromPhoneNumber(phoneNumber);
      }
      await _userDatasource.getUserByUid(userModel.uid);
      return userModel.isNewUser;
    } on UserNotFoundException catch (_) {
      return true;
    } catch (e) {
      rethrow;
    }
  }
}
