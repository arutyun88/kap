import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:kap/services/environment_service.dart';
import 'package:kap/services/storage_keys.dart';

class StorageService extends GetxService {
  static StorageService to = Get.find<StorageService>();

  StorageService._(this.themeName, this.localeName);

  static Future<void> init() async {
    Hive.init(EnvironmentService.to.documentsDirectory.path);
    final box = await Hive.openBox(StorageKeys.settings);
    final String? theme = box.get(StorageKeys.theme);
    final String? locale = box.get(StorageKeys.locale);
    Get.lazyPut(() => StorageService._(theme.obs, locale.obs));
  }

  final Rx<String?> themeName;
  final Rx<String?> localeName;
}
