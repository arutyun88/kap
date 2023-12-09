abstract interface class AuthorizationDatasource {
  Future<void> phoneVerification(
    String phoneNumber,
    void Function(String) whenSuccess,
    void Function(Exception) whenFailed,
  );
}
