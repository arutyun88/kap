import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:kap/services/settings/localization_service.dart';

extension LocalizationsExtension on BuildContext {
  AppLocalizations get dictionary => AppLocalizations.of(this)!;
}

const String _regex = r"\{(.*?)\}";

class CustomAppLocalizations extends AppLocalizations {
  CustomAppLocalizations(super.locale);

  final _localizedStrings = LocalizationService.to.data;

  AppLocalizations get _default => lookupAppLocalizations(Locale(localeName));

  @override
  String helloWithUsername(String username) {
    final message = _localizedStrings[localeName]?['helloWithUsername'];
    if (message == null) return _default.helloWithUsername(username);
    return message.replaceFirst(RegExp(_regex), username);
  }

  @override
  String get language => _localizedStrings[localeName]?['language'] ?? _default.language;

  @override
  String get feed => _localizedStrings[localeName]?['feed'] ?? _default.feed;

  @override
  String get messages => _localizedStrings[localeName]?['messages'] ?? _default.messages;

  @override
  String get profile => _localizedStrings[localeName]?['profile'] ?? _default.profile;

  @override
  String get settings => _localizedStrings[localeName]?['settings'] ?? _default.settings;
}
