import 'package:hive/hive.dart';
import 'package:kap/datasource/authorization/local_authorization_datasource.dart';
import 'package:kap/services/storage/storage_keys.dart';

class HiveAuthorizationDatasource implements LocalAuthorizationDatasource {
  @override
  Future<bool> checkIsAuthorized() async {
    try {
      final box = await Hive.openBox(StorageKeys.settings);
      final data = await box.get(StorageKeys.isLogged);
      return data;
    } on TypeError {
      return false;
    } catch (_) {
      rethrow;
    }
  }
}
