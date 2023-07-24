import 'dart:convert';
import 'dart:ui';

import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:kap/config/environment.dart';
import 'package:kap/config/l10n/app_localization_custom_delegate.dart';
import 'package:kap/services/environment_service.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:kap/services/firebase_service.dart';

class LocalizationService extends GetxService {
  LocalizationService._(this.data, this.delegate);

  final Map<String, Map<String, String>> data;
  final List<LocalizationsDelegate> delegate;

  static LocalizationService to = Get.find<LocalizationService>();

  final _locale = const Locale('ru').obs;

  @override
  void onInit() {
    super.onInit();
    _locale.value = _platformLocale();
  }

  static Future<void> init() async {
    final env = EnvironmentService.to.environment;
    final appInfo = EnvironmentService.to.appInfo;
    final fData = (await FirebaseService.to.database
            .ref(env == Environment.prod ? '${env.name}/${appInfo.version.split('.').first}' : env.name)
            .get())
        .value;

    var delegate = [
      fData == null ? AppLocalizations.delegate : const AppLocalizationsCustomDelegate(),
      GlobalMaterialLocalizations.delegate,
      GlobalCupertinoLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate,
    ];

    Map<String, Map<String, String>> convertedMap = {};
    if (fData != null) {
      jsonDecode(jsonEncode(fData)).forEach((key, value) {
        if (value is Map<String, dynamic>) {
          Map<String, String> subMap = {};
          value.forEach((subKey, subValue) {
            if (subValue is String) subMap[subKey] = subValue;
          });
          convertedMap[key] = subMap;
        }
      });
    }

    return Get.lazyPut(() => LocalizationService._(convertedMap, delegate));
  }

  Locale get locale => _locale.value;

  void changeLocale(Locale? selectedLocale) {
    if (selectedLocale == null || !AppLocalizations.delegate.isSupported(selectedLocale)) {
      _locale.value = _platformLocale();
    } else {
      _locale.value = selectedLocale;
    }
  }

  Locale _platformLocale() => PlatformDispatcher.instance.locale;
}
