import 'dart:developer';
import 'dart:ui';

import 'package:hive/hive.dart';
import 'package:kap/config/l10n/custom_app_localizations.dart';
import 'package:kap/datasource/localization/local_localization_datasource.dart';
import 'package:kap/domain/exceptions/custom_exception.dart';
import 'package:kap/services/storage/storage_keys.dart';

class HiveLocalizationDatasource implements LocalLocalizationDatasource {
  const HiveLocalizationDatasource();

  @override
  Future<Map<String, dynamic>> getData() async {
    const failedMessage = 'LocalizationDataGettingException: HiveLocalizationDatasource: getData: failed';

    late Box box;

    try {
      box = await Hive.openBox(StorageKeys.settings);
      final data = await box.get(StorageKeys.localizations);
      if (data == null) throw const LocalizationDataGettingException(failedMessage);
      if (data is! Map<String, dynamic>) throw TypeError();
      return data;
    } on TypeError {
      throw const LocalizationDataGettingException(failedMessage);
    } catch (e) {
      log('${e.runtimeType}: HiveLocalizationDatasource: getVersion: $e');
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
          'LocalizationVersionCheckException: HiveLocalizationDatasource: getVersion: failed');
    } catch (e) {
      log('${e.runtimeType}: HiveLocalizationDatasource: getVersion: $e');
      rethrow;
    } finally {
      await box.close();
    }
  }

  @override
  Future<Locale?> getCurrentLocale() async {
    final Box box = await Hive.openBox(StorageKeys.settings);
    final currentLocale = await box.get(StorageKeys.currentLocale);
    await box.close();
    if (currentLocale is! String) return null;
    return currentLocale.locale;
  }

  @override
  Future<void> setCurrentLocale(Locale? locale) async {
    final Box box = await Hive.openBox(StorageKeys.settings);
    await box.put(StorageKeys.currentLocale, locale?.canonized);
  }
}
