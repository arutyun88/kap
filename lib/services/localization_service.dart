import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:kap/config/environment.dart';
import 'package:kap/config/l10n/app_localization_custom_delegate.dart';
import 'package:kap/services/environment_service.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LocalizationService extends GetxService {
  LocalizationService._(this.data, this.delegate);

  static Future<void> init() async {
    final env = EnvironmentService.to.environment;
    final appInfo = EnvironmentService.to.appInfo;
    final fData = (await FirebaseDatabase.instance
            .ref(env == Environment.prod ? '${env.name}/${appInfo.version.split('.').first}' : env.name)
            .get())
        .value;

    var delegate = [
      AppLocalizations.delegate,
      GlobalMaterialLocalizations.delegate,
      GlobalCupertinoLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate,
    ];

    Map<String, Map<String, String>> convertedMap = {};
    if (fData != null) {
      delegate[0] = const AppLocalizationsCustomDelegate();
      jsonDecode(jsonEncode(fData)).forEach((key, value) {
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

    return Get.lazyPut(() => LocalizationService._(convertedMap, delegate));
  }

  final Map<String, Map<String, String>> data;

  final List<LocalizationsDelegate> delegate;

  static LocalizationService to = Get.find<LocalizationService>();
}
