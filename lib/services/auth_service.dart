import 'package:get/get.dart';
import 'package:kap/services/storage/storage_keys.dart';
import 'package:kap/services/storage/storage_service.dart';

class AuthService extends GetxService {
  AuthService(this.isAuthorized);

  static Future<void> init() async {
    final bool authorized = (await StorageService.to.box.get(StorageKeys.isLogged)) ?? false;
    Get.put(AuthService(authorized.obs));
  }

  static AuthService get to => Get.find<AuthService>();

  final Rx<bool> isAuthorized;
}
