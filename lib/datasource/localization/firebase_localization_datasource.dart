import 'dart:convert';
import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:kap/config/environment.dart';
import 'package:kap/datasource/localization/localization_datasource.dart';
import 'package:kap/domain/exceptions/custom_exception.dart';
import 'package:kap/services/environment_service.dart';
import 'package:kap/services/storage/storage_keys.dart';

class FirebaseLocalizationDatasource implements LocalizationDatasource {
  final FirebaseDatabase firebaseDatabase;

  FirebaseLocalizationDatasource({required this.firebaseDatabase});

  @override
  Future<Map<String, dynamic>> getData() async {
    try {
      final data = await _getData('${_getPath()}/${StorageKeys.data}');
      return data != null ? jsonDecode(jsonEncode(data)) : <String, dynamic>{};
    } catch (e) {
      throw _getException(e, 'getData');
    }
  }

  @override
  Future<int> getVersion() async {
    try {
      final version = await _getData('${_getPath()}/${StorageKeys.version}');
      if (version == null || version is! int) {
        throw const LocalizationVersionCheckException(
            'LocalizationVersionCheckException: FirebaseLocalizationDatasource: getVersion: failed');
      }
      return version;
    } on LocalizationVersionCheckException {
      rethrow;
    } catch (e) {
      throw _getException(e, 'getVersion');
    }
  }

  String _getPath() {
    final appInfo = EnvironmentService.to.appInfo;
    final env = EnvironmentService.to.environment;
    return env == Environment.prod ? '${env.name}/${appInfo.version.split('.').first}' : env.name;
  }

  Future<Object?> _getData(String path) async => (await firebaseDatabase.ref(path).get()).value;

  Object _getException(Object e, String methodName) {
    if (e is FirebaseException) {
      throw LocalizationDataGettingException(
          '${e.runtimeType}: FirebaseLocalizationDatasource: $methodName: ${e.message}');
    }
    log('${e.runtimeType}: FirebaseLocalizationDatasource: $methodName: $e');
    return e;
  }
}
