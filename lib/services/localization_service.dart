import 'dart:developer';

import 'package:get/get.dart';
import 'package:kap/domain/exceptions/custom_exception.dart';
import 'package:kap/repositories/localization_repository.dart';

class NewLocalizationService extends GetxService {
  NewLocalizationService._(this._localizationRepository);

  static void init(LocalizationRepository localizationRepository) {
    Get.put(NewLocalizationService._(localizationRepository));
  }

  final LocalizationRepository _localizationRepository;

  static final NewLocalizationService to = Get.find<NewLocalizationService>();

  final RxMap<String, dynamic> localization = <String, dynamic>{}.obs;

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
