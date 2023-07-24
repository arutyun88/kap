import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:kap/config/l10n/custom_app_localizations.dart';

class AppLocalizationsCustomDelegate extends LocalizationsDelegate<AppLocalizations> {
  const AppLocalizationsCustomDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(CustomAppLocalizations(locale.languageCode));
  }

  @override
  bool isSupported(Locale locale) =>
      AppLocalizations.supportedLocales.map((e) => e.languageCode).toList().contains(locale.languageCode);

  @override
  bool shouldReload(AppLocalizationsCustomDelegate old) => false;
}
