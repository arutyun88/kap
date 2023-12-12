import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:hive_test/hive_test.dart';
import 'package:kap/datasource/authorization/hive_authorization_datasource.dart';
import 'package:kap/datasource/authorization/local_authorization_datasource.dart';
import 'package:kap/services/storage/storage_keys.dart';

import '../../resources/utils.dart';

main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late final LocalAuthorizationDatasource hiveLocalizationDatasource;

  setUpAll(() async {
    await setUpTestHive();
    await utilSetUp();

    hiveLocalizationDatasource = HiveAuthorizationDatasource();
  });

  tearDownAll(() async => await tearDownTestHive());

  tearDown(() async => (await Hive.openBox(StorageKeys.settings)).clear());

  group('checkIsAuthorized tests', () {
    test('when user is logged', () async {
      (await Hive.openBox(StorageKeys.settings)).put(StorageKeys.isLogged, true);

      final actual = await hiveLocalizationDatasource.checkIsAuthorized();
      expect(actual, true);
    });

    test('when user is not logged', () async {
      (await Hive.openBox(StorageKeys.settings)).put(StorageKeys.isLogged, false);

      final actual = await hiveLocalizationDatasource.checkIsAuthorized();
      expect(actual, false);
    });

    test('when catch type error', () async {
      (await Hive.openBox(StorageKeys.settings)).put(StorageKeys.isLogged, null);

      final actual = await hiveLocalizationDatasource.checkIsAuthorized();
      expect(actual, false);
    });
  });

  group('updateAuthorizedState tests', () {
    test('when set state authorized', () async {
      await hiveLocalizationDatasource.updateAuthorizedState(true);

      expect((await Hive.openBox(StorageKeys.settings)).get(StorageKeys.isLogged), true);
    });

    test('when set state not authorized', () async {
      await hiveLocalizationDatasource.updateAuthorizedState(false);

      expect((await Hive.openBox(StorageKeys.settings)).get(StorageKeys.isLogged), false);
    });
  });
}
