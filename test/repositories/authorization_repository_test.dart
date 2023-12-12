import 'package:flutter_test/flutter_test.dart';
import 'package:kap/datasource/authorization/authorization_datasource.dart';
import 'package:kap/datasource/device/device_datasource.dart';
import 'package:kap/domain/exceptions/custom_exception.dart';
import 'package:kap/domain/models/device_model/device_model.dart';
import 'package:kap/repositories/authorization_repository.dart';
import 'package:mocktail/mocktail.dart';

import '../mocks.dart';
import '../resources/test_const.dart';

main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late AuthorizationRepository authorizationRepository;
  late AuthorizationDatasource authorizationDatasource;
  late DeviceDatasource deviceDatasource;

  setUp(() {
    authorizationDatasource = MockAuthorizationDatasource();
    deviceDatasource = MockDeviceDatasource();
    authorizationRepository = AuthorizationRepository(
      remoteAuthorizationDatasource: authorizationDatasource,
      deviceDatasource: deviceDatasource,
    );
    when(deviceDatasource.getDeviceByDeviceId).thenAnswer((_) => Future.value(DeviceModel.fromJson(deviceInfo)));
  });

  group('phoneVerification tests', () {
    test('when device is used and refers to number', () async {
      when(deviceDatasource.getDeviceByDeviceId).thenAnswer((_) => Future.value(DeviceModel.fromJson(deviceInfo)));
      when(() => authorizationDatasource.phoneVerification(any(), any(), any())).thenAnswer((_) => Future.value());

      expect(
        authorizationRepository.phoneVerification('+12345678901', whenSuccess: (value) {}, whenFailed: (e) {}),
        isNot(isA<Exception>()),
      );
    });

    test('when device is not used', () async {
      when(deviceDatasource.getDeviceByDeviceId).thenAnswer((_) => Future.value(null));
      when(() => authorizationDatasource.phoneVerification(any(), any(), any())).thenAnswer((_) => Future.value());

      expect(
        authorizationRepository.phoneVerification('+12345678901', whenSuccess: (value) {}, whenFailed: (e) {}),
        isNot(isA<Exception>()),
      );
    });

    test('when device already use and phone is not the same', () async {
      when(deviceDatasource.getDeviceByDeviceId).thenAnswer((_) => Future.value(DeviceModel.fromJson(deviceInfo)));

      expect(
        authorizationRepository.phoneVerification('+12345678900', whenSuccess: (value) {}, whenFailed: (e) {}),
        throwsA(isA<DeviceAlreadyUseException>()),
      );
    });
  });

  group('codeVerification tests', () {
    test('when not throw exceptions', () async {
      when(() => authorizationDatasource.verifyOtp(
            verificationId: any(named: 'verificationId'),
            smsCode: any(named: 'smsCode'),
          )).thenAnswer((_) => Future.value('some_uid'));
      when(() => deviceDatasource.createDeviceFromPhoneNumber(any())).thenAnswer((_) => Future.value());

      await expectLater(
        authorizationRepository.codeVerification(verificationId: 'id', smsCode: 'code', phoneNumber: 'number'),
        isNot(isA<Exception>()),
      );
      verify(() => authorizationDatasource.verifyOtp(
            verificationId: any(named: 'verificationId'),
            smsCode: any(named: 'smsCode'),
          )).called(1);
      verify(() => deviceDatasource.createDeviceFromPhoneNumber(any())).called(1);
    });

    test('when throw device datasource exception', () async {
      when(() => authorizationDatasource.verifyOtp(
            verificationId: any(named: 'verificationId'),
            smsCode: any(named: 'smsCode'),
          )).thenAnswer((_) => Future.value('some_uid'));
      when(() => deviceDatasource.createDeviceFromPhoneNumber(any())).thenThrow(Exception());

      await expectLater(
        authorizationRepository.codeVerification(verificationId: 'id', smsCode: 'code', phoneNumber: 'number'),
        throwsA(isA<Exception>()),
      );
      verify(() => authorizationDatasource.verifyOtp(
            verificationId: any(named: 'verificationId'),
            smsCode: any(named: 'smsCode'),
          )).called(1);
      verify(() => deviceDatasource.createDeviceFromPhoneNumber(any())).called(1);
    });

    test('when throw device authorization exception', () async {
      when(() => authorizationDatasource.verifyOtp(
            verificationId: any(named: 'verificationId'),
            smsCode: any(named: 'smsCode'),
          )).thenThrow(Exception());

      await expectLater(
        authorizationRepository.codeVerification(verificationId: 'id', smsCode: 'code', phoneNumber: 'number'),
        throwsA(isA<Exception>()),
      );
      verify(() => authorizationDatasource.verifyOtp(
            verificationId: any(named: 'verificationId'),
            smsCode: any(named: 'smsCode'),
          )).called(1);
      verifyNever(() => deviceDatasource.createDeviceFromPhoneNumber(any()));
    });
  });
}
