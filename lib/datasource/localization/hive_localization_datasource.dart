import 'dart:convert';
import 'dart:ui';

import 'package:hive/hive.dart';
import 'package:kap/config/l10n/custom_app_localizations.dart';
import 'package:kap/datasource/localization/local_localization_datasource.dart';
import 'package:kap/domain/exceptions/localization_exception.dart';
import 'package:kap/services/storage/storage_keys.dart';

class HiveLocalizationDatasource implements LocalLocalizationDatasource {
  const HiveLocalizationDatasource();

  @override
  Future<Map<String, dynamic>> getData() async {
    final Box box = await Hive.openBox(StorageBoxNames.settings);
    final data = await box.get(StorageKeys.localizations);
    if (data == null) throw LocalizationNotFoundException();
    return jsonDecode(jsonEncode(data));
  }

  @override
  Future<void> setData(Map<String, dynamic> data, int version) async {
    final Box box = await Hive.openBox(StorageBoxNames.settings);
    await box.put(StorageKeys.localizations, data);
    await box.put(StorageKeys.localizationVersion, version);
  }

  @override
  Future<int> getVersion() async {
    final Box box = await Hive.openBox(StorageBoxNames.settings);
    return await box.get(StorageKeys.localizationVersion, defaultValue: 0);
  }

  @override
  Future<Locale?> getCurrentLocale() async {
    final Box box = await Hive.openBox(StorageBoxNames.settings);
    final currentLocale = await box.get(StorageKeys.currentLocale);
    if (currentLocale is! String) return null;
    return currentLocale.locale;
  }

  @override
  Future<void> setCurrentLocale(Locale? locale) async {
    final Box box = await Hive.openBox(StorageBoxNames.settings);
    await box.put(StorageKeys.currentLocale, locale?.canonized);
  }
}
