import 'dart:convert';
import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:kap/config/environment.dart';
import 'package:kap/datasource/localization/localization_datasource.dart';
import 'package:kap/domain/exceptions/custom_exception.dart';
import 'package:kap/services/environment_service.dart';

class FirebaseLocalizationDatasource implements LocalizationDatasource {
  final FirebaseDatabase firebaseDatabase;

  FirebaseLocalizationDatasource({required this.firebaseDatabase});

  @override
  Future<Map<String, dynamic>> getData() async {
    try {
      final appInfo = EnvironmentService.to.appInfo;
      final env = EnvironmentService.to.environment;
      final firebaseDataPath = env == Environment.prod ? '${env.name}/${appInfo.version.split('.').first}' : env.name;
      final data = await firebaseDatabase.ref(firebaseDataPath).get();
      Map<String, dynamic> map = {};
      if (data.value != null) map = jsonDecode(jsonEncode(data.value));
      return map;
    } on FirebaseException catch (e) {
      throw LocalizationDataGettingException('${e.runtimeType}: FirebaseLocalizationDatasource: ${e.message}');
    } catch (e) {
      log('${e.runtimeType}: FirebaseLocalizationDatasource: $e');
      rethrow;
    }
  }

  @override
  Future<int> getVersion() {
    // TODO: implement getVersion
    throw UnimplementedError();
  }
}
