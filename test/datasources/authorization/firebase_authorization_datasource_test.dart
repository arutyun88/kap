import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kap/datasource/authorization/firebase_authorization_datasource.dart';
import 'package:kap/domain/exceptions/authorization_exception.dart';
import 'package:mocktail/mocktail.dart';

import '../../mocks.dart';

main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late FirebaseAuthorizationDatasource firebaseAuthorizationDatasource;
  late FirebaseAuth firebaseAuth;
  late UserCredential userCredential;
  late AdditionalUserInfo additionalUserInfo;
  late User firebaseUser;

  setUpAll(() {
    firebaseAuth = MockFirebaseAuth();
    additionalUserInfo = MockAdditionalUserInfo();
    firebaseAuthorizationDatasource = FirebaseAuthorizationDatasource.init(firebaseAuth);
    userCredential = MockUserCredential();
    firebaseUser = FakeFirebaseUser();

    registerFallbackValue(FakeDuration());
    registerFallbackValue(FakeAuthCredential());
  });

  group('phoneVerification tests', () {
    test('when phoneVerification called once', () async {
      when(
        () => firebaseAuth.verifyPhoneNumber(
          phoneNumber: any(named: 'phoneNumber'),
          timeout: any(named: 'timeout'),
          verificationCompleted: any(named: 'verificationCompleted'),
          verificationFailed: any(named: 'verificationFailed'),
          codeSent: any(named: 'codeSent'),
          codeAutoRetrievalTimeout: any(named: 'codeAutoRetrievalTimeout'),
        ),
      ).thenAnswer((_) async => Future.value());

      await firebaseAuthorizationDatasource.phoneVerification('+79202024422', (id) {}, (exc) {});

      verify(() => firebaseAuth.verifyPhoneNumber(
            phoneNumber: any(named: 'phoneNumber'),
            timeout: any(named: 'timeout'),
            verificationCompleted: any(named: 'verificationCompleted'),
            verificationFailed: any(named: 'verificationFailed'),
            codeSent: any(named: 'codeSent'),
            codeAutoRetrievalTimeout: any(named: 'codeAutoRetrievalTimeout'),
          )).called(1);
    });
  });

  group('verifyOtp tests', () {
    test('when sms-code is verified', () async {
      when(() => firebaseAuth.signInWithCredential(any())).thenAnswer((_) => Future.value(userCredential));
      when(() => userCredential.user).thenReturn(firebaseUser);
      when(() => userCredential.additionalUserInfo).thenReturn(additionalUserInfo);
      when(() => additionalUserInfo.isNewUser).thenReturn(true);

      expect(await firebaseAuthorizationDatasource.verifyOtp(verificationId: 'id', smsCode: 'code'), true);
    });

    test('when sms-code is not verified', () async {
      when(() => firebaseAuth.signInWithCredential(any())).thenThrow(FirebaseAuthException(code: '100'));

      expect(
        () => firebaseAuthorizationDatasource.verifyOtp(verificationId: 'id', smsCode: 'code'),
        throwsA(isA<CodeException>()),
      );
    });
  });
}
