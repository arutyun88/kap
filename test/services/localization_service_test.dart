import 'dart:convert';
import 'dart:io';
import 'dart:ui';

import 'package:flutter_test/flutter_test.dart';
import 'package:kap/config/extensions/map_extensions.dart';
import 'package:kap/config/l10n/custom_app_localizations.dart';
import 'package:kap/domain/exceptions/custom_exception.dart';
import 'package:kap/repositories/localization_repository.dart';
import 'package:kap/services/settings/localization_service.dart';
import 'package:mocktail/mocktail.dart';

import '../mocks.dart';

main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late LocalizationRepository localizationRepository;
  late LocalizationService localizationService;
  late Map<String, Map<String, String>> localizationMap;

  setUpAll(() async {
    localizationMap =
        (jsonDecode(await File('test/resources/localization_test_file.json').readAsString())['data'] as Map).convertTo;
    localizationRepository = MockLocalizationRepository();

    when(localizationRepository.checkAndUpdateLocalization).thenAnswer((_) => Future.value(localizationMap));
    when(localizationRepository.getCurrentLocale).thenAnswer((_) => Future.value('ru_RU'.locale));

    await LocalizationService.init(localizationRepository);
    localizationService = LocalizationService.to;
  });

  group('localization service tests', () {
    group('localizationService initialization tests', () {
      test(' service is initialized', () => expect(localizationService.runtimeType, LocalizationService));

      test('locale is initialized', () => expect(LocalizationService.locale.value, 'ru_RU'.locale));
    });

    test('localization service success test', () async {
      when(localizationRepository.checkAndUpdateLocalization).thenAnswer((_) => Future.value(localizationMap));

      await localizationService.checkAndUpdateLocalization();

      expect(localizationService.localization, equals(localizationMap));
      verify(() => localizationRepository.checkAndUpdateLocalization()).called(2);
    });

    group('localization service failed tests', () {
      test('localization service throw LocalizationException', () async {
        when(localizationRepository.checkAndUpdateLocalization).thenThrow(
          const LocalizationVersionCheckException('an error occurred while checking the version\'s up-to-date'),
        );

        expect(localizationService.checkAndUpdateLocalization, throwsA(isA<LocalizationException>()));
      });

      test('localization service throw other Exception', () async {
        when(localizationRepository.checkAndUpdateLocalization).thenThrow(Exception('other error'));

        expect(localizationService.checkAndUpdateLocalization, throwsA(isNot(isA<LocalizationException>())));
      });
    });
  });

  group('setLocale tests', () {
    test('setLocale when locale is not null', () async {
      when(() => localizationRepository.setCurrentLocale(any())).thenAnswer((_) => Future.value());

      await localizationService.setLocale('ru_RU'.locale);

      expect(LocalizationService.locale.value, 'ru_RU'.locale);
      verify(() => localizationRepository.setCurrentLocale(any())).called(1);
    });

    test('setLocale when locale is null', () async {
      when(() => localizationRepository.setCurrentLocale(any())).thenAnswer((_) => Future.value());

      await localizationService.setLocale(null);

      expect(LocalizationService.locale.value, PlatformDispatcher.instance.locale);
      verify(() => localizationRepository.setCurrentLocale(any())).called(1);
    });
  });
}
