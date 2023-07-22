import 'package:get/get.dart';

import '../config/environment.dart';

class EnvironmentService extends GetxService {
  EnvironmentService._(this.environment);

  static EnvironmentService init(Environment env) => Get.put(EnvironmentService._(env));

  final Environment environment;

  static EnvironmentService to = Get.find<EnvironmentService>();
}
