abstract interface class LocalizationDatasource {
  Future<int> getVersion();

  Future<Map<String, dynamic>> getData();
}
