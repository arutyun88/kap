import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:kap/config/l10n/app_localization_custom_delegate.dart';
import 'package:kap/services/settings/localization_service.dart';

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

  static final _localization = LocalizationService.to.localization;

  static final List<Locale> supportedLocales =
      _localization.isNotEmpty ? _localization.keys.map((e) => e.locale).toList() : AppLocalizations.supportedLocales;

  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    AppLocalizationsCustomDelegate(),
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  final Locale _locale;

  AppLocalizations get _default => lookupAppLocalizations(AppLocalizations.supportedLocales.first);

  String get _cLocale => _locale.canonized;

  @override
  String helloWithUsername(String username) {
    final message = _localization[_cLocale]?['helloWithUsername'];
    if (message == null) return _default.helloWithUsername(username);
    return message.replaceFirst(RegExp(_regex), username);
  }

  @override
  String get language => _localization[_cLocale]?['language'] ?? _default.language;

  @override
  String get feed => _localization[_cLocale]?['feed'] ?? _default.feed;

  @override
  String get authorizationTitle => _localization[_cLocale]?['authorizationTitle'] ?? _default.authorizationTitle;

  @override
  String get messages => _localization[_cLocale]?['messages'] ?? _default.messages;

  @override
  String get profile => _localization[_cLocale]?['profile'] ?? _default.profile;

  @override
  String get settings => _localization[_cLocale]?['settings'] ?? _default.settings;

  @override
  String get authorizationDescription =>
      _localization[_cLocale]?['authorizationDescription'] ?? _default.authorizationDescription;

  @override
  String get continueButton => _localization[_cLocale]?['continueButton'] ?? _default.continueButton;

  @override
  String get authorizationHint => _localization[_cLocale]?['authorizationHint'] ?? _default.authorizationHint;

  @override
  String get authorizationNeed => _localization[_cLocale]?['authorizationNeed'] ?? _default.authorizationNeed;

  @override
  String get authorizationCode => _localization[_cLocale]?['authorizationCode'] ?? _default.authorizationCode;

  @override
  String get sessionExpired => _localization[_cLocale]?['sessionExpired'] ?? _default.sessionExpired;

  @override
  String get verificationCodeInvalid =>
      _localization[_cLocale]?['verificationCodeInvalid'] ?? _default.verificationCodeInvalid;

  @override
  String get cancelButtonTitle => _localization[_cLocale]?['cancelButtonTitle'] ?? _default.cancelButtonTitle;

  @override
  String get continueButtonTitle => _localization[_cLocale]?['continueButtonTitle'] ?? _default.continueButtonTitle;

  @override
  String get registrationIncompleteExitPrompt =>
      _localization[_cLocale]?['registrationIncompleteExitPrompt']?.multiline ??
      _default.registrationIncompleteExitPrompt;
}

extension _StringExtension on String {
  String get multiline => replaceAll(r'\n', '\n');
}
