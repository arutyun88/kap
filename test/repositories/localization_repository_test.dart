import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:kap/datasource/localization/local_localization_datasource.dart';
import 'package:kap/datasource/localization/localization_datasource.dart';
import 'package:kap/domain/exceptions/custom_exception.dart';
import 'package:kap/repositories/localization_repository.dart';
import 'package:mocktail/mocktail.dart';

import '../mocks.dart';

main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late LocalizationRepository localizationRepository;
  late LocalLocalizationDatasource localLocalizationDatasource;
  late LocalizationDatasource remoteLocalizationDatasource;
  late Map<String, dynamic> localizationMap;

  setUpAll(() async {
    localizationMap = jsonDecode(await File('test/resources/localization_test_file.json').readAsString());
    localLocalizationDatasource = MockLocalLocalizationDatasource();
    remoteLocalizationDatasource = MockRemoteLocalizationDatasource();
    localizationRepository = LocalizationRepository(
      localLocalizationDatasource: localLocalizationDatasource,
      remoteLocalizationDatasource: remoteLocalizationDatasource,
    );
  });

  group('localization repository tests', () {
    group('localization repository success tests', () {
      test('localization repository success when local and remote versions are the same', () async {
        when(localLocalizationDatasource.getVersion).thenAnswer((_) => Future.value(1));
        when(remoteLocalizationDatasource.getVersion).thenAnswer((_) => Future.value(1));
        when(localLocalizationDatasource.getData).thenAnswer((_) => Future.value(localizationMap));

        await localizationRepository.checkAndUpdateLocalization();

        verify(() => localLocalizationDatasource.getVersion()).called(1);
        verify(() => remoteLocalizationDatasource.getVersion()).called(1);
        verify(() => localLocalizationDatasource.getData()).called(1);
        verifyNever(() => remoteLocalizationDatasource.getData());
      });

      test('localization repository success when local and remote versions do not match', () async {
        when(localLocalizationDatasource.getVersion).thenAnswer((_) => Future.value(1));
        when(remoteLocalizationDatasource.getVersion).thenAnswer((_) => Future.value(2));
        when(remoteLocalizationDatasource.getData).thenAnswer((_) => Future.value(localizationMap));

        await localizationRepository.checkAndUpdateLocalization();

        verify(() => localLocalizationDatasource.getVersion()).called(1);
        verify(() => remoteLocalizationDatasource.getVersion()).called(1);
        verifyNever(() => localLocalizationDatasource.getData());
        verify(() => remoteLocalizationDatasource.getData()).called(1);
      });
    });

    group('localization repository failed tests', () {
      test('localization repository throws an exception when checking the local version', () async {
        when(localLocalizationDatasource.getVersion).thenThrow(
          const LocalizationVersionCheckException('an error occurred while checking the local version'),
        );

        await expectLater(
          localizationRepository.checkAndUpdateLocalization,
          throwsA(isA<LocalizationVersionCheckException>()),
        );

        verify(() => localLocalizationDatasource.getVersion()).called(1);
        verifyNever(() => remoteLocalizationDatasource.getVersion());
        verifyNever(() => localLocalizationDatasource.getData());
        verifyNever(() => remoteLocalizationDatasource.getData());
      });

      test('localization repository throws an exception when checking the remote version', () async {
        when(localLocalizationDatasource.getVersion).thenAnswer((_) => Future.value(1));
        when(remoteLocalizationDatasource.getVersion).thenThrow(
          const LocalizationVersionCheckException('an error occurred while checking the remote version'),
        );

        await expectLater(
          localizationRepository.checkAndUpdateLocalization,
          throwsA(isA<LocalizationVersionCheckException>()),
        );

        verify(localLocalizationDatasource.getVersion).called(1);
        verify(remoteLocalizationDatasource.getVersion).called(1);
        verifyNever(() => localLocalizationDatasource.getData());
        verifyNever(() => remoteLocalizationDatasource.getData());
      });

      test('localization repository throws an exception when receive data from local storage', () async {
        when(localLocalizationDatasource.getVersion).thenAnswer((_) => Future.value(1));
        when(remoteLocalizationDatasource.getVersion).thenAnswer((_) => Future.value(1));
        when(localLocalizationDatasource.getData).thenThrow(
          const LocalizationDataGettingException('an error occurred while retrieving data from the local storage'),
        );

        await expectLater(
          localizationRepository.checkAndUpdateLocalization,
          throwsA(isA<LocalizationDataGettingException>()),
        );

        verify(localLocalizationDatasource.getVersion).called(1);
        verify(remoteLocalizationDatasource.getVersion).called(1);
        verify(() => localLocalizationDatasource.getData()).called(1);
        verifyNever(() => remoteLocalizationDatasource.getData());
      });

      test('localization repository throws an exception when receive data from remote storage', () async {
        when(localLocalizationDatasource.getVersion).thenAnswer((_) => Future.value(1));
        when(remoteLocalizationDatasource.getVersion).thenAnswer((_) => Future.value(2));
        when(remoteLocalizationDatasource.getData).thenThrow(
          const LocalizationDataGettingException('an error occurred while retrieving data from the remote storage'),
        );

        await expectLater(
          localizationRepository.checkAndUpdateLocalization,
          throwsA(isA<LocalizationDataGettingException>()),
        );

        verify(localLocalizationDatasource.getVersion).called(1);
        verify(remoteLocalizationDatasource.getVersion).called(1);
        verify(() => remoteLocalizationDatasource.getData()).called(1);
        verifyNever(() => localLocalizationDatasource.getData());
      });
    });
  });
}
