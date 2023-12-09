import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kap/datasource/authorization/firebase_authorization_datasource.dart';
import 'package:mocktail/mocktail.dart';

import '../../mocks.dart';

main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late FirebaseAuthorizationDatasource firebaseAuthorizationDatasource;
  late FirebaseAuth firebaseAuth;

  setUp(() {
    firebaseAuth = MockFirebaseAuth();
    firebaseAuthorizationDatasource = FirebaseAuthorizationDatasource.init(firebaseAuth);
  });
  setUpAll(() {
    registerFallbackValue(FakeDuration());
  });

  test('FirebaseAuthorizationDatasource  then firebaseAuth.verifyPhoneNumber called once', () async {
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

    await firebaseAuthorizationDatasource.phoneVerification(
      '+79202024422',
      (p0) {},
      (p0) {},
    );

    verify(() => firebaseAuth.verifyPhoneNumber(
          phoneNumber: any(named: 'phoneNumber'),
          timeout: any(named: 'timeout'),
          verificationCompleted: any(named: 'verificationCompleted'),
          verificationFailed: any(named: 'verificationFailed'),
          codeSent: any(named: 'codeSent'),
          codeAutoRetrievalTimeout: any(named: 'codeAutoRetrievalTimeout'),
        )).called(1);
  });
}
