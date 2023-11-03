import 'package:get/get.dart';

class WidgetsSizeService extends GetxService {
  static WidgetsSizeService init() => Get.put(WidgetsSizeService(), permanent: true);

  static WidgetsSizeService get to => Get.find<WidgetsSizeService>();
  final _bottomBarHeight = 56.0.obs;

  RxDouble get bottomBarHeight => _bottomBarHeight;

  setBottomBarHeight(double value) => _bottomBarHeight.value = value;
}
