import 'dart:io';

import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:path_provider/path_provider.dart';

import '../config/environment.dart';

class EnvironmentService extends GetxService {
  EnvironmentService._(this.environment, this.appInfo, this.documentsDirectory);

  static Future<void> init(Environment env) async {
    final info = await PackageInfo.fromPlatform();
    final documentsDirectory = await getApplicationDocumentsDirectory();
    Get.lazyPut(() => EnvironmentService._(env, info, documentsDirectory));
  }

  final Environment environment;
  final PackageInfo appInfo;
  final Directory documentsDirectory;

  static EnvironmentService to = Get.find<EnvironmentService>();
}
