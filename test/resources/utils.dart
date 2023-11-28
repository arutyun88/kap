import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

import 'test_const.dart';

Future<void> utilSetUp() async {
  TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
      .setMockMethodCallHandler(const MethodChannel('plugins.flutter.io/path_provider'), (_) async => '.');
  TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(
    const MethodChannel('dev.fluttercommunity.plus/package_info'),
    (MethodCall call) async => call.method == 'getAll' ? await Future.value(packageInfo) : await Future.value(),
  );
}
