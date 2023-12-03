import 'dart:developer';
import 'dart:ui';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';
import 'package:kap/config/l10n/custom_app_localizations.dart';
import 'package:kap/domain/exceptions/custom_exception.dart';
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

  final RxMap<String, Map<String, String>> localization = <String, Map<String, String>>{}.obs;

  Future<void> checkAndUpdateLocalization() async {
    try {
      localization.value = await _localizationRepository.checkAndUpdateLocalization();
    } on LocalizationException catch (e) {
      log('${e.runtimeType}: ${e.message}');
      rethrow;
    } on Exception catch (e) {
      log('${e.runtimeType}: e');
      rethrow;
    }
  }

  Future<void> setLocale(Locale? uLocale) async {
    await _localizationRepository.setCurrentLocale(uLocale);
    if (uLocale == null) {
      final platformLocale = PlatformDispatcher.instance.locale;
      locale.value = CustomAppLocalizations.supportedLocales.contains(platformLocale)
          ? platformLocale
          : AppLocalizations.supportedLocales.first;
    } else {
      locale.value = uLocale;
    }
  }

  Future<void> _updateCurrentLocale() async {
    final currentLocale = await _localizationRepository.getCurrentLocale();
    if (currentLocale != null) {
      locale.value = currentLocale;
      return;
    }
    final platformLocale = PlatformDispatcher.instance.locale;
    if (CustomAppLocalizations.supportedLocales.contains(platformLocale)) {
      locale.value = platformLocale;
    } else {
      locale.value = AppLocalizations.supportedLocales.first;
    }
  }
}
