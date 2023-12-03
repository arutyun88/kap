import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:kap/config/extensions/map_extensions.dart';
import 'package:kap/domain/exceptions/custom_exception.dart';
import 'package:kap/repositories/localization_repository.dart';
import 'package:kap/services/localization_service.dart';
import 'package:mocktail/mocktail.dart';

import '../mocks.dart';

main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late LocalizationRepository localizationRepository;
  late NewLocalizationService localizationService;
  late Map<String, Map<String, String>> localizationMap;

  setUpAll(() async {
    localizationMap =
        (jsonDecode(await File('test/resources/localization_test_file.json').readAsString())['data'] as Map).convertTo;
    localizationRepository = MockLocalizationRepository();
    when(localizationRepository.checkAndUpdateLocalization).thenAnswer((_) => Future.value(localizationMap));
    await NewLocalizationService.init(localizationRepository);
    localizationService = NewLocalizationService.to;
  });

  group('localization service tests', () {
    test(
      'localization service is initialized',
      () => expect(localizationService.runtimeType, NewLocalizationService),
    );

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
}
