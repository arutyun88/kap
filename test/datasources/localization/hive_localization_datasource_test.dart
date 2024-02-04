import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:hive_test/hive_test.dart';
import 'package:kap/config/l10n/custom_app_localizations.dart';
import 'package:kap/datasource/localization/hive_localization_datasource.dart';
import 'package:kap/domain/exceptions/localization_exception.dart';
import 'package:kap/services/storage/storage_keys.dart';
import 'package:mocktail/mocktail.dart';

import '../../resources/utils.dart';

class MockBox extends Mock implements Box {}

main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late final HiveLocalizationDatasource hiveLocalizationDatasource;

  late final Map<String, dynamic> localizations;

  setUpAll(() async {
    await setUpTestHive();
    await utilSetUp();

    hiveLocalizationDatasource = const HiveLocalizationDatasource();
    localizations = jsonDecode(await File('test/resources/localization_test_file.json').readAsString());
  });

  tearDownAll(() async => await tearDownTestHive());

  tearDown(() async => (await Hive.openBox(StorageBoxNames.settings)).clear());

  group('getData tests', () {
    group('getData success tests', () {
      test('getData when data find', () async {
        (await Hive.openBox(StorageBoxNames.settings)).put(StorageKeys.localizations, localizations['data']);

        final actual = await hiveLocalizationDatasource.getData();

        expect(actual, localizations['data']);
      });
    });
    group('getData failed tests', () {
      test('getData when data type is not Map<String, dynamic>', () async {
        expect(hiveLocalizationDatasource.getData(), throwsA(isA<LocalizationNotFoundException>()));
      });
    });
  });

  group('setData tests', () {
    group('setData success tests', () {
      test('setData when data find', () async {
        await hiveLocalizationDatasource.setData(localizations['data'], localizations['version']);

        final box = await Hive.openBox(StorageBoxNames.settings);
        expect(box.get(StorageKeys.localizations), localizations['data']);
        expect(box.get(StorageKeys.localizationVersion), localizations['version']);
      });
    });
  });

  group('getVersion tests', () {
    group('getVersion success tests', () {
      test('getVersion when version find', () async {
        (await Hive.openBox(StorageBoxNames.settings)).put(StorageKeys.localizationVersion, localizations['version']);

        expect(await hiveLocalizationDatasource.getVersion(), localizations['version']);
      });

      test('getVersion when version not find', () async => expect(await hiveLocalizationDatasource.getVersion(), 0));
    });
  });

  group('getCurrentLocale tests', () {
    group('getCurrentLocale success tests', () {
      test('getCurrentLocale when locale find', () async {
        (await Hive.openBox(StorageBoxNames.settings)).put(StorageKeys.currentLocale, 'en_US');
        expect(await hiveLocalizationDatasource.getCurrentLocale(), 'en_US'.locale);
      });

      test('getCurrentLocale when locale not found', () async {
        (await Hive.openBox(StorageBoxNames.settings)).put(StorageKeys.currentLocale, null);
        expect(await hiveLocalizationDatasource.getCurrentLocale(), null);
      });

      test('getCurrentLocale when locale is not String', () async {
        (await Hive.openBox(StorageBoxNames.settings)).put(StorageKeys.currentLocale, 1);
        expect(await hiveLocalizationDatasource.getCurrentLocale(), null);
      });
    });
  });

  group('setCurrentLocale tests', () {
    group('setCurrentLocale success tests', () {
      test('setCurrentLocale when locale find', () async {
        await hiveLocalizationDatasource.setCurrentLocale('en_US'.locale);
        expect((await Hive.openBox(StorageBoxNames.settings)).get(StorageKeys.currentLocale), 'en_US');
      });

      test('setCurrentLocale when locale not found', () async {
        await hiveLocalizationDatasource.setCurrentLocale(null);
        expect((await Hive.openBox(StorageBoxNames.settings)).get(StorageKeys.currentLocale), null);
      });
    });
  });
}
