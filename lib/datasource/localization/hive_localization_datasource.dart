import 'dart:developer';

import 'package:hive/hive.dart';
import 'package:kap/datasource/localization/local_localization_datasource.dart';
import 'package:kap/domain/exceptions/custom_exception.dart';
import 'package:kap/services/storage/storage_keys.dart';

class HiveLocalizationDatasource implements LocalLocalizationDatasource {
  const HiveLocalizationDatasource();

  @override
  Future<Map<String, dynamic>> getData() {
    // TODO: implement getData
    throw UnimplementedError();
  }

  @override
  Future<int> getVersion() async {
    late final Box box;
    try {
      box = await Hive.openBox(StorageKeys.settings);
      final version = await box.get(StorageKeys.localizationVersion);
      return version ?? 0;
    } on TypeError {
      throw const LocalizationVersionCheckException(
          'LocalizationVersionCheckException: FirebaseLocalizationDatasource: getVersion: failed');
    } catch (e) {
      log('${e.runtimeType}: FirebaseLocalizationDatasource: getVersion: $e');
      rethrow;
    } finally {
      await box.close();
    }
  }
}
