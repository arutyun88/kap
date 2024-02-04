import 'dart:ui';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';
import 'package:kap/config/l10n/custom_app_localizations.dart';
import 'package:kap/repositories/localization_repository.dart';

class LocalizationService extends GetxService {
  LocalizationService._(this._localizationRepository);

  static Future<void> init(LocalizationRepository localizationRepository) async {
    final isRegistered = Get.isRegistered<LocalizationService>();
    if (!isRegistered) {
      final service = Get.put(LocalizationService._(localizationRepository));
      await service.checkAndUpdateLocalization();
      await service._updateCurrentLocale();
    }
  }

  final LocalizationRepository _localizationRepository;

  static final LocalizationService to = Get.find<LocalizationService>();
  static final Rx<Locale> locale = const Locale('ru', 'RU').obs;

  static Locale get _platformLocale => PlatformDispatcher.instance.locale;

  final RxMap<String, Map<String, String>> localization = <String, Map<String, String>>{}.obs;

  Future<void> checkAndUpdateLocalization() async {
    try {
      localization.value = await _localizationRepository.checkAndUpdateLocalization();
    } catch (_) {
      return;
    }
  }

  Future<void> setLocale(Locale? uLocale) async =>
      await _localizationRepository.setCurrentLocale(uLocale).whenComplete(() => _setLocale(uLocale));

  Future<void> _updateCurrentLocale() async => _setLocale(await _localizationRepository.getCurrentLocale());

  void _setLocale(Locale? currentLocale) {
    if (currentLocale != null) {
      locale.value = currentLocale;
      return;
    }
    final supportedLocales = CustomAppLocalizations.supportedLocales;
    locale.value = supportedLocales.contains(_platformLocale)
        ? _platformLocale
        : supportedLocales.firstWhereOrNull((element) => element.languageCode == _platformLocale.languageCode) ??
            AppLocalizations.supportedLocales.first;
  }
}
