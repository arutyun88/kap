import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:kap/domain/enums/verify_code_state.dart';
import 'package:kap/domain/exceptions/authorization_exception.dart';
import 'package:kap/repositories/authorization_repository.dart';
import 'package:kap/services/auth_service.dart';
import 'package:mocktail/mocktail.dart';

import '../mocks.dart';

main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late AuthService authService;
  late AuthorizationRepository authorizationRepository;
  late BuildContext context;

  setUpAll(() async {
    context = FakeBuildContext();
    authorizationRepository = MockAuthorizationRepository();
    when(authorizationRepository.checkLocalAuthState).thenAnswer((_) => Future.value(true));
    await AuthService.init(authorizationRepository);
    authService = AuthService.to;
  });

  group('init tests', () {
    test('service is initialized', () async {
      expect(Get.isRegistered<AuthService>(), true);
      expect(authService.isAuthorized.value, true);
      verify(authorizationRepository.checkLocalAuthState).called(1);
    });

    group('success tests', () {
      test('when phone verified', () {
        when(
          () => authorizationRepository.phoneVerification(
            any(),
            whenSuccess: any(named: 'whenSuccess'),
            whenFailed: any(named: 'whenFailed'),
          ),
        ).thenAnswer((_) => Future.value());

        expect(
          authService.sendVerificationCodeByPhoneNumber('', context, whenSuccess: (value) {}, whenFailed: (exc) {}),
          isNot(isA<Exception>),
        );
      });

      test('when sms code verified', () async {
        when(
          () => authorizationRepository.codeVerification(
            verificationId: any(named: 'verificationId'),
            smsCode: any(named: 'smsCode'),
            phoneNumber: any(named: 'phoneNumber'),
          ),
        ).thenAnswer((_) => Future.value(true));
        when(() => authorizationRepository.setLocalAuthState(any())).thenAnswer((_) => Future.value());

        final result = await authService.verifyPhoneCode(context, phoneNumber: '', verificationId: '', smsCode: '');

        expect(authService.isAuthorized.value, true);
        expect(result, VerifyCodeState.verifiedNewUser);
        verify(() => authorizationRepository.codeVerification(
              verificationId: any(named: 'verificationId'),
              smsCode: any(named: 'smsCode'),
              phoneNumber: any(named: 'phoneNumber'),
            )).called(1);
      });
    });
  });

  group('failed tests', () {
    test('when sms code is invalid', () async {
      when(
        () => authorizationRepository.codeVerification(
          verificationId: any(named: 'verificationId'),
          smsCode: any(named: 'smsCode'),
          phoneNumber: any(named: 'phoneNumber'),
        ),
      ).thenThrow(const CodeException('message'));

      final actual = await authService.verifyPhoneCode(context, phoneNumber: '', verificationId: '', smsCode: '');

      expect(actual, VerifyCodeState.error);
      verify(() => authorizationRepository.codeVerification(
            verificationId: any(named: 'verificationId'),
            smsCode: any(named: 'smsCode'),
            phoneNumber: any(named: 'phoneNumber'),
          )).called(1);
    });

    test('when sms code is expired', () async {
      when(
        () => authorizationRepository.codeVerification(
          verificationId: any(named: 'verificationId'),
          smsCode: any(named: 'smsCode'),
          phoneNumber: any(named: 'phoneNumber'),
        ),
      ).thenThrow(const TimeoutException('message'));

      final actual = await authService.verifyPhoneCode(context, phoneNumber: '', verificationId: '', smsCode: '');

      expect(actual, VerifyCodeState.expired);
      verify(() => authorizationRepository.codeVerification(
            verificationId: any(named: 'verificationId'),
            smsCode: any(named: 'smsCode'),
            phoneNumber: any(named: 'phoneNumber'),
          )).called(1);
    });
  });
}
