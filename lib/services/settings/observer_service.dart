import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:kap/services/settings/localization_service.dart';
import 'package:kap/services/settings/theme_service.dart';
import 'package:kap/services/storage/storage_keys.dart';
import 'package:kap/services/storage/storage_service.dart';

class ObserverService extends GetxService with WidgetsBindingObserver {
  static ObserverService init() => Get.put(ObserverService());

  static ObserverService to = Get.find<ObserverService>();

  @override
  void didChangePlatformBrightness() {
    super.didChangePlatformBrightness();
    final themeName = StorageService.to.box.get(StorageKeys.theme);
    if (themeName == null) ThemeService.to.change(null);
  }

  @override
  void didChangeLocales(List<Locale>? locales) {
    super.didChangeLocales(locales);
    final localeName = StorageService.to.box.get(StorageKeys.locale);
    if (localeName == null && locales != null && locales.isNotEmpty) {
      LocalizationService.changeLocale(locales.first);
    }
  }

  @override
  void onInit() {
    WidgetsBinding.instance.addObserver(this);
    super.onInit();
  }

  @override
  void onClose() {
    WidgetsBinding.instance.removeObserver(this);
    super.onClose();
  }
}
