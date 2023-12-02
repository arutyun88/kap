import 'dart:developer';

import 'package:get/get.dart';
import 'package:kap/domain/exceptions/custom_exception.dart';
import 'package:kap/repositories/localization_repository.dart';

class NewLocalizationService extends GetxService {
  NewLocalizationService._(this._localizationRepository);

  static Future<void> init(LocalizationRepository localizationRepository) async {
    final isRegistered = Get.isRegistered<NewLocalizationService>();
    if (!isRegistered) {
      final service = Get.put(NewLocalizationService._(localizationRepository));
      await service.checkAndUpdateLocalization();
    }
  }

  final LocalizationRepository _localizationRepository;

  static final NewLocalizationService to = Get.find<NewLocalizationService>();

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
}
