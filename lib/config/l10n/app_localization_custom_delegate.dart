import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:kap/config/l10n/custom_app_localizations.dart';

class AppLocalizationsCustomDelegate extends LocalizationsDelegate<AppLocalizations> {
  const AppLocalizationsCustomDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) => SynchronousFuture<CustomAppLocalizations>(_customLookup(locale));

  @override
  bool isSupported(Locale locale) => CustomAppLocalizations.supportedLocales.contains(locale);

  @override
  bool shouldReload(AppLocalizationsCustomDelegate old) => false;
}

CustomAppLocalizations _customLookup(Locale locale) => CustomAppLocalizations(locale);
