import 'package:firebase_auth/firebase_auth.dart';
import 'package:kap/datasource/authorization/authorization_datasource.dart';
import 'package:kap/domain/exceptions/authorization_exception.dart';
import 'package:kap/domain/models/user_auth_model/user_auth_model.dart';

class FirebaseAuthorizationDatasource implements AuthorizationDatasource {
  final FirebaseAuth _auth;
  static FirebaseAuthorizationDatasource? _instance;

  FirebaseAuthorizationDatasource._(this._auth);

  factory FirebaseAuthorizationDatasource.init(FirebaseAuth auth) {
    _instance ??= FirebaseAuthorizationDatasource._(auth);
    return _instance!;
  }

  static FirebaseAuthorizationDatasource get instance =>
      _instance ?? FirebaseAuthorizationDatasource.init(FirebaseAuth.instance);

  @override
  Future<void> phoneVerification(
    String phoneNumber,
    void Function(String) whenSuccess,
    void Function(Exception) whenFailed,
  ) async {
    await _auth.verifyPhoneNumber(
      timeout: const Duration(minutes: 2),
      phoneNumber: phoneNumber,
      verificationCompleted: (credentials) {},
      verificationFailed: (exception) {
        if (exception.code == 'too-many-requests') {
          whenFailed(TooMachException(exception.message ?? 'firebase auth exception'));
          return;
        }
        whenFailed(AuthorizationException(exception.message ?? 'firebase auth exception'));
      },
      codeSent: (verificationId, token) => whenSuccess(verificationId),
      codeAutoRetrievalTimeout: (_) {
        whenFailed(const TimeoutException('AuthorizationTimeoutException: authorization process times out'));
      },
    );
  }

  @override
  Future<UserAuthModel> verifyOtp({
    required String verificationId,
    required String smsCode,
  }) async {
    final credential = PhoneAuthProvider.credential(verificationId: verificationId, smsCode: smsCode);
    try {
      final user = await _auth.signInWithCredential(credential);
      return UserAuthModel(
        isNewUser: user.additionalUserInfo?.isNewUser ?? false,
        uid: user.user?.uid ?? '',
        phoneNumber: user.user?.phoneNumber ?? '',
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'session-expired') {
        throw TimeoutException(e.message ?? 'The SMS code has expired');
      }
      if (e.code == 'invalid-verification-code') {
        throw CodeException(e.message ?? 'The verification code used to create the auth credential is invalid');
      }
      rethrow;
    } catch (e) {
      rethrow;
    }
  }
}
