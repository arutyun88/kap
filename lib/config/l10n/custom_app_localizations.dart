import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:kap/config/l10n/app_localization_custom_delegate.dart';
import 'package:kap/services/localization_service.dart';

extension LocalizationsExtension on BuildContext {
  AppLocalizations get dictionary => AppLocalizations.of(this)!;
}

extension LocaleCanonizedExtension on Locale {
  String get canonized => '${languageCode}_$countryCode';
}

extension LocaleExtension on String {
  Locale get locale {
    final sThis = split('_');
    return Locale(sThis.first, sThis.last);
  }
}

const String _regex = r"\{(.*?)\}";

class CustomAppLocalizations extends AppLocalizations {
  CustomAppLocalizations(Locale locale)
      : _locale = locale,
        super(locale.languageCode);

  static CustomAppLocalizations? of(BuildContext context) {
    return Localizations.of<CustomAppLocalizations>(context, CustomAppLocalizations);
  }

  static final List<Locale> supportedLocales =
      NewLocalizationService.to.localization.keys.map((e) => e.locale).toList();

  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    AppLocalizationsCustomDelegate(),
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  final Locale _locale;

  final _localizedStrings = NewLocalizationService.to.localization;

  AppLocalizations get _default => lookupAppLocalizations(AppLocalizations.supportedLocales.first);

  String get _cLocale => _locale.canonized;

  @override
  String helloWithUsername(String username) {
    final message = _localizedStrings[_cLocale]?['helloWithUsername'];
    if (message == null) return _default.helloWithUsername(username);
    return message.replaceFirst(RegExp(_regex), username);
  }

  @override
  String get language => _localizedStrings[_cLocale]?['language'] ?? _default.language;

  @override
  String get feed => _localizedStrings[_cLocale]?['feed'] ?? _default.feed;

  @override
  String get authorizationTitle => _localizedStrings[_cLocale]?['authorizationTitle'] ?? _default.authorizationTitle;

  @override
  String get messages => _localizedStrings[_cLocale]?['messages'] ?? _default.messages;

  @override
  String get profile => _localizedStrings[_cLocale]?['profile'] ?? _default.profile;

  @override
  String get settings => _localizedStrings[_cLocale]?['settings'] ?? _default.settings;

  @override
  String get authorizationDescription =>
      _localizedStrings[_cLocale]?['authorizationDescription'] ?? _default.authorizationDescription;

  @override
  String get continueButton => _localizedStrings[_cLocale]?['continueButton'] ?? _default.continueButton;

  @override
  String get authorizationHint => _localizedStrings[_cLocale]?['authorizationHint'] ?? _default.authorizationHint;
}
