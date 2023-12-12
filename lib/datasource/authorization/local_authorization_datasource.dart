abstract interface class LocalAuthorizationDatasource {
  Future<bool> checkIsAuthorized();

  Future<void> updateAuthorizedState(bool state);
}
