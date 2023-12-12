abstract interface class LocalAuthorizationDatasource {
  Future<bool> checkIsAuthorized();
}
