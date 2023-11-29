import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:hive_test/hive_test.dart';
import 'package:kap/datasource/localization/hive_localization_datasource.dart';
import 'package:kap/domain/exceptions/custom_exception.dart';
import 'package:kap/services/storage/storage_keys.dart';
import 'package:mocktail/mocktail.dart';

class MockBox extends Mock implements Box {}

main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late final HiveLocalizationDatasource hiveLocalizationDatasource;

  setUpAll(() async {
    hiveLocalizationDatasource = const HiveLocalizationDatasource();
  });
  setUp(() async => await setUpTestHive());
  tearDown(() async => await tearDownTestHive());

  group('getData tests', () {});

  group('getVersion tests', () {
    group('success tests', () {
      test('when version find', () async {
        (await Hive.openBox(StorageKeys.settings)).put(StorageKeys.localizationVersion, 1);
        await expectLater(await hiveLocalizationDatasource.getVersion(), 1);
        expect(Hive.isBoxOpen(StorageKeys.settings), false);
      });
      test('when version not find', () async {
        await expectLater(await hiveLocalizationDatasource.getVersion(), 0);
        expect(Hive.isBoxOpen(StorageKeys.settings), false);
      });
    });
    group('failed tests', () {
      test('when version is not int', () async {
        (await Hive.openBox('settings')).put(StorageKeys.localizationVersion, '1');
        await expectLater(hiveLocalizationDatasource.getVersion, throwsA(isA<LocalizationVersionCheckException>()));
        expect(Hive.isBoxOpen(StorageKeys.settings), false);
      });
    });
  });
}
