import 'package:flutter_test/flutter_test.dart';
import 'package:kap/config/environment.dart';
import 'package:kap/services/environment_service.dart';

import '../resources/utils.dart';

main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  final appInfo = {'appName': 'kap', 'packageName': 'com.kap', 'version': '1.0.0', 'buildNumber': '1'};
  const directory = '.';

  setUpAll(() async => utilSetUp());

  test('environment service is init as develop', () async {
    const env = Environment.dev;
    await EnvironmentService.init(env);
    final EnvironmentService service = EnvironmentService.to;

    expect(service.runtimeType, EnvironmentService);
    expect(service.environment, env);
    expect(service.appInfo.data, appInfo);
    expect(service.documentsDirectory.path, directory);
  });
}
