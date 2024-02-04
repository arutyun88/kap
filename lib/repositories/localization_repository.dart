import 'dart:ui';

import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:kap/config/extensions/map_extensions.dart';
import 'package:kap/datasource/localization/local_localization_datasource.dart';
import 'package:kap/datasource/localization/localization_datasource.dart';

class LocalizationRepository {
  final LocalLocalizationDatasource _localLocalizationDatasource;
  final LocalizationDatasource _remoteLocalizationDatasource;
  final InternetConnectionChecker _internetConnectionChecker;

  const LocalizationRepository({
    required LocalLocalizationDatasource localLocalizationDatasource,
    required LocalizationDatasource remoteLocalizationDatasource,
    required InternetConnectionChecker internetConnectionChecker,
  })  : _localLocalizationDatasource = localLocalizationDatasource,
        _remoteLocalizationDatasource = remoteLocalizationDatasource,
        _internetConnectionChecker = internetConnectionChecker;

  Future<Map<String, Map<String, String>>> checkAndUpdateLocalization() async {
    try {
      if (await _internetConnectionChecker.hasConnection) {
        final remoteVersion = await _remoteLocalizationDatasource.getVersion();
        if (await _localLocalizationDatasource.getVersion() < remoteVersion) {
          await _localLocalizationDatasource.setData(await _remoteLocalizationDatasource.getData(), remoteVersion);
        }
      }
      return (await _localLocalizationDatasource.getData()).convertTo;
    } catch (_) {
      rethrow;
    }
  }

  Future<Locale?> getCurrentLocale() async {
    return _localLocalizationDatasource.getCurrentLocale();
  }

  Future<void> setCurrentLocale(Locale? locale) async {
    _localLocalizationDatasource.setCurrentLocale(locale);
  }
}
