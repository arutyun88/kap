import 'dart:convert';
import 'dart:io';
import 'dart:ui';

import 'package:flutter_test/flutter_test.dart';
import 'package:kap/config/extensions/map_extensions.dart';
import 'package:kap/config/l10n/custom_app_localizations.dart';
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

    when(localizationRepository.getCurrentLocale).thenAnswer((_) => Future.value('ru_RU'.locale));

    await LocalizationService.init(localizationRepository);
    localizationService = LocalizationService.to;
  });

  tearDown(() {
    localizationService.localization.clear();
  });

  group('LocalizationService initialization tests', () {
    test(' service is initialized', () => expect(localizationService.runtimeType, LocalizationService));

    test('locale is initialized', () => expect(LocalizationService.locale.value, 'ru_RU'.locale));
  });

  group('LocalizationService tests', () {
    group('checkAndUpdateLocalization tests', () {
      test('checkAndUpdateLocalization success test', () async {
        when(localizationRepository.checkAndUpdateLocalization).thenAnswer((_) => Future.value(localizationMap));

        await localizationService.checkAndUpdateLocalization();

        expect(localizationService.localization, equals(localizationMap));
      });

      test('checkAndUpdateLocalization throw Exception', () async {
        when(localizationRepository.checkAndUpdateLocalization).thenThrow(Exception());

        await localizationService.checkAndUpdateLocalization();

        expect(localizationService.localization, isEmpty);
      });
    });

    group('setLocale tests', () {
      setUpAll(() {
        when(() => localizationRepository.setCurrentLocale(any())).thenAnswer((_) => Future.value());
      });

      test('setLocale when locale is not null', () async {
        await localizationService.setLocale('ru_RU'.locale);

        expect(LocalizationService.locale.value, 'ru_RU'.locale);
        verify(() => localizationRepository.setCurrentLocale(any())).called(1);
      });

      test('setLocale when locale is null', () async {
        await localizationService.setLocale(null);

        expect(LocalizationService.locale.value.languageCode, PlatformDispatcher.instance.locale.languageCode);
        verify(() => localizationRepository.setCurrentLocale(any())).called(1);
      });
    });
  });
}
