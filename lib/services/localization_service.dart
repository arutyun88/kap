import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';
import 'package:kap/services/environment_service.dart';

class LocalizationService extends GetxService {
  LocalizationService._(this.data);

  static Future<void> init() async {
    final env = EnvironmentService.to.environment;
    final appInfo = EnvironmentService.to.appInfo;
    final fData = await FirebaseDatabase.instance.ref('${env.name}/${appInfo.version.split('.').first}').get();
    var result = fData.value;

    Map<String, Map<String, String>> convertedMap = {};
    if (result != null) {
      jsonDecode(jsonEncode(result)).forEach((key, value) {
        if (value is Map<String, dynamic>) {
          Map<String, String> subMap = {};
          value.forEach((subKey, subValue) {
            if (subValue is String) {
              subMap[subKey] = subValue;
            }
          });
          convertedMap[key] = subMap;
        }
      });
    }
    if (convertedMap.isEmpty) {
      convertedMap = keys;
    }

    return Get.lazyPut(() => LocalizationService._(convertedMap));
  }

  final Map<String, Map<String, String>> data;

  static LocalizationService to = Get.find<LocalizationService>();
}

Map<String, Map<String, String>> get keys => {
      'en_US': {
        'hello': 'Hello World',
      },
      'de_DE': {
        'hello': 'Hallo Welt',
      }
    };
