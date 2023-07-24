import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../config/environment.dart';

class EnvironmentService extends GetxService {
  EnvironmentService._(this.environment, this.appInfo);

  static Future<void> init(Environment env) async {
    final info = await PackageInfo.fromPlatform();
    Get.lazyPut(() => EnvironmentService._(env, info));
  }

  final Environment environment;
  final PackageInfo appInfo;

  static EnvironmentService to = Get.find<EnvironmentService>();
}
