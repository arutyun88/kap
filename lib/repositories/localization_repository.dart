import 'dart:developer';

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

  Future<Map<String, dynamic>> checkAndUpdateLocalization() async {
    try {
      final localVersion = await _localLocalizationDatasource.getVersion();
      final remoteVersion = await _remoteLocalizationDatasource.getVersion();
      if (localVersion < remoteVersion) {
        return  await _remoteLocalizationDatasource.getData();
      }
      return await _localLocalizationDatasource.getData();
    } on LocalizationException catch (e) {
      log('${e.runtimeType}: LocalizationRepository: ${e.message}');
      rethrow;
    } catch (_) {
      rethrow;
    }
  }
}
