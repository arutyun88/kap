import 'package:kap/datasource/localization/local_localization_datasource.dart';
import 'package:kap/datasource/localization/localization_datasource.dart';
import 'package:kap/repositories/localization_repository.dart';
import 'package:mocktail/mocktail.dart';

class MockRemoteLocalizationDatasource extends Mock implements LocalizationDatasource {}

class MockLocalLocalizationDatasource extends Mock implements LocalLocalizationDatasource {}

class MockLocalizationRepository extends Mock implements LocalizationRepository {}
