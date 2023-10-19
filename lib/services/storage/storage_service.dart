import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:kap/services/environment_service.dart';
import 'package:kap/services/storage_keys.dart';

class StorageService extends GetxService {
  static StorageService to = Get.find<StorageService>();

  StorageService._(this.box);

  static Future<void> init() async {
    Hive.init(EnvironmentService.to.documentsDirectory.path);
    final box = await Hive.openBox(StorageKeys.settings);
    Get.lazyPut(() => StorageService._(box));
  }

  Future<void> set(String key, dynamic value) async => await box.put(key, value);

  final Box box;
}
