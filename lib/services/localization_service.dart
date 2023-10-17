import 'dart:convert';
import 'dart:developer';
import 'dart:ui';

import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:kap/config/environment.dart';
import 'package:kap/config/l10n/app_localization_custom_delegate.dart';
import 'package:kap/services/environment_service.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:kap/services/firebase_service.dart';
import 'package:kap/services/storage_keys.dart';
import 'package:package_info_plus/package_info_plus.dart';

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
    final value = await Hive.openBox(StorageKeys.settings);
    log(value.keys.toString());
    log(value.values.toString());

    final env = EnvironmentService.to.environment;
    final appInfo = EnvironmentService.to.appInfo;
    log(env.name.toString());
    log(appInfo.toString());
    final fData = await _getData(env, appInfo);
    var delegate = [
      fData == null ? AppLocalizations.delegate : const AppLocalizationsCustomDelegate(),
      GlobalMaterialLocalizations.delegate,
      GlobalCupertinoLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate,
    ];
    final convertedMap = await _setData(fData, env);
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

  static Future<dynamic> _getData(Environment env, PackageInfo appInfo) async {
    try {
      final firebaseDataPath = env == Environment.prod ? '${env.name}/${appInfo.version.split('.').first}' : env.name;
      final localizationVersion =
          (await FirebaseService.to.database.ref('$firebaseDataPath/${StorageKeys.version}').get()).value;
      final settings = Hive.box(StorageKeys.settings);
      final sVersion = settings.get(StorageKeys.localizationVersion);
      final scope = settings.get(StorageKeys.scope);
      if (sVersion == null || sVersion != localizationVersion || scope == null || scope != env.name) {
        final data = (await FirebaseService.to.database.ref(firebaseDataPath).get()).value;
        if (data != null) return data;
      } else {
        return settings.get(StorageKeys.localizations);
      }
    } catch (e) {
      return null;
    }
  }

  static Future<Map<String, Map<String, String>>> _setData(dynamic data, Environment env) async {
    Map<String, Map<String, String>> convertedMap = {};
    if (data != null) {
      jsonDecode(jsonEncode(data)).forEach((key, value) {
        if (key == StorageKeys.version) {
          Hive.box(StorageKeys.settings).put(StorageKeys.localizationVersion, value);
        }
        if (value is Map<String, dynamic>) {
          Map<String, String> subMap = {};
          value.forEach(
            (subKey, subValue) {
              if (subValue is String) subMap[subKey] = subValue;
            },
          );
          convertedMap[key] = subMap;
        }
      });
    }
    await Hive.box(StorageKeys.settings).put(StorageKeys.scope, env.name);
    await Hive.box(StorageKeys.settings).put(StorageKeys.localizations, convertedMap);
    return convertedMap;
  }
}
