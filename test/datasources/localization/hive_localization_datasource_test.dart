import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:hive_test/hive_test.dart';
import 'package:kap/datasource/localization/hive_localization_datasource.dart';
import 'package:kap/domain/exceptions/custom_exception.dart';
import 'package:kap/services/storage/storage_keys.dart';
import 'package:mocktail/mocktail.dart';

import '../../resources/utils.dart';

class MockBox extends Mock implements Box {}

main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late final HiveLocalizationDatasource hiveLocalizationDatasource;

  setUpAll(() async {
    await setUpTestHive();
    await utilSetUp();

    hiveLocalizationDatasource = const HiveLocalizationDatasource();
  });

  tearDownAll(() async => await tearDownTestHive());

  tearDown(() async => (await Hive.openBox(StorageKeys.settings)).clear());

  group('getData tests', () {
    group('getData success tests', () {
      test('getData when data find', () async {
        final localizations = jsonDecode(await File('test/resources/localization_test_file.json').readAsString());
        (await Hive.openBox(StorageKeys.settings)).put(StorageKeys.localizations, localizations['data']);

        await expectLater(await hiveLocalizationDatasource.getData(), localizations['data']);
        expect(Hive.isBoxOpen(StorageKeys.settings), false);
      });
    });
    group('getData failed tests', () {
      test('getData when data type is not Map<String, dynamic>', () async {
        (await Hive.openBox(StorageKeys.settings)).put(StorageKeys.localizations, 1);

        await expectLater(hiveLocalizationDatasource.getData(), throwsA(isA<LocalizationDataGettingException>()));
        expect(Hive.isBoxOpen(StorageKeys.settings), false);
      });

      test('getData when data type is not Map<String, dynamic>', () async {
        (await Hive.openBox(StorageKeys.settings)).put(StorageKeys.localizations, 1);

        await expectLater(hiveLocalizationDatasource.getData(), throwsA(isA<LocalizationDataGettingException>()));
        expect(Hive.isBoxOpen(StorageKeys.settings), false);
      });
    });
  });

  group('getVersion tests', () {
    group('getVersion success tests', () {
      test('getVersion when version find', () async {
        (await Hive.openBox(StorageKeys.settings)).put(StorageKeys.localizationVersion, 1);
        await expectLater(await hiveLocalizationDatasource.getVersion(), 1);
        expect(Hive.isBoxOpen(StorageKeys.settings), false);
      });

      test('getVersion when version not find', () async {
        await expectLater(await hiveLocalizationDatasource.getVersion(), 0);
        expect(Hive.isBoxOpen(StorageKeys.settings), false);
      });
    });

    group('getVersion failed tests', () {
      test('getVersion when version is not int', () async {
        (await Hive.openBox('settings')).put(StorageKeys.localizationVersion, '1');
        await expectLater(hiveLocalizationDatasource.getVersion(), throwsA(isA<LocalizationVersionCheckException>()));
        expect(Hive.isBoxOpen(StorageKeys.settings), false);
      });
    });
  });
}
