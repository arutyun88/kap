import 'dart:ui';

import 'package:kap/datasource/localization/localization_datasource.dart';

abstract interface class LocalLocalizationDatasource implements LocalizationDatasource {
  Future<Locale?> getCurrentLocale();
}
