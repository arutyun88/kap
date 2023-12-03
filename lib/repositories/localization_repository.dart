import 'dart:developer';
import 'dart:ui';

import 'package:kap/config/extensions/map_extensions.dart';
import 'package:kap/datasource/localization/local_localization_datasource.dart';
import 'package:kap/datasource/localization/localization_datasource.dart';
import 'package:kap/domain/exceptions/custom_exception.dart';

class LocalizationRepository {
  final LocalLocalizationDatasource _localLocalizationDatasource;
  final LocalizationDatasource _remoteLocalizationDatasource;

  const LocalizationRepository({
    required LocalLocalizationDatasource localLocalizationDatasource,
    required LocalizationDatasource remoteLocalizationDatasource,
  })  : _localLocalizationDatasource = localLocalizationDatasource,
        _remoteLocalizationDatasource = remoteLocalizationDatasource;

  Future<Map<String, Map<String, String>>> checkAndUpdateLocalization() async {
    try {
      final localVersion = await _localLocalizationDatasource.getVersion();
      final remoteVersion = await _remoteLocalizationDatasource.getVersion();
      if (localVersion < remoteVersion) {
        return (await _remoteLocalizationDatasource.getData()).convertTo;
      }
      return (await _localLocalizationDatasource.getData()).convertTo;
    } on LocalizationException catch (e) {
      log('${e.runtimeType}: LocalizationRepository: ${e.message}');
      rethrow;
    } catch (_) {
      rethrow;
    }
  }

  Future<Locale?> getCurrentLocale() async {
    return _localLocalizationDatasource.getCurrentLocale();
  }
}
