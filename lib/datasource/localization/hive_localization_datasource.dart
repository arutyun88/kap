import 'dart:developer';

import 'package:hive/hive.dart';
import 'package:kap/datasource/localization/local_localization_datasource.dart';
import 'package:kap/domain/exceptions/custom_exception.dart';
import 'package:kap/services/storage/storage_keys.dart';

class HiveLocalizationDatasource implements LocalLocalizationDatasource {
  const HiveLocalizationDatasource();

  @override
  Future<Map<String, dynamic>> getData() async {
    const failedMessage = 'LocalizationDataGettingException: FirebaseLocalizationDatasource: getData: failed';

    late Box box;

    try {
      box = Hive.box(StorageKeys.settings);
      final data = await box.get(StorageKeys.localizations);
      if (data == null) throw const LocalizationDataGettingException(failedMessage);
      if (data is! Map<String, dynamic>) throw TypeError();
      return data;
    } on TypeError {
      throw const LocalizationDataGettingException(failedMessage);
    } catch (e) {
      log('${e.runtimeType}: FirebaseLocalizationDatasource: getVersion: $e');
      rethrow;
    } finally {
      await box.close();
    }
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
