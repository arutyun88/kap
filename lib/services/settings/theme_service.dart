import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:kap/config/theme/app_theme.dart';
import 'package:kap/services/storage/storage_service.dart';
import 'package:kap/services/storage/storage_keys.dart';

class ThemeService extends GetxService {
  ThemeService._(this.theme);

  static ThemeService to = Get.find<ThemeService>();

  static Future<void> init() async {
    final themeName = StorageService.to.box.get(StorageKeys.theme);
    final ThemeData themeData = themeName == null
        ? _platformTheme()
        : themeName == AppTheme.dark.brightness.name
            ? AppTheme.dark
            : AppTheme.light;
    Get.lazyPut(() => ThemeService._(themeData.obs));
  }

  static ThemeData _platformTheme() =>
      SchedulerBinding.instance.platformDispatcher.platformBrightness == Brightness.dark
          ? AppTheme.dark
          : AppTheme.light;

  final Rx<ThemeData> theme;

  void change(ThemeData? value) {
    theme.value = value ?? _platformTheme();
    StorageService.to.set(StorageKeys.theme, value?.brightness.name);
  }
}
