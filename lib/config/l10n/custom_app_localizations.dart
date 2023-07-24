import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kap/services/localization_service.dart';

extension LocalizationsExtension on BuildContext {
  AppLocalizations get dictionary => AppLocalizations.of(this)!;
}

const String _regex = r"\{(.*?)\}";

class CustomAppLocalizations extends AppLocalizations {
  CustomAppLocalizations(super.locale);

  final _localizedStrings = Get.find<LocalizationService>().data;

  AppLocalizations get _default => lookupAppLocalizations(Locale(localeName));

  @override
  String helloWithUsername(String username) {
    final message = _localizedStrings[localeName]?['helloWithUsername'];
    if (message == null) return _default.helloWithUsername(username);
    return message.replaceFirst(RegExp(_regex), username);
  }

  @override
  String get language => _localizedStrings[localeName]?['language'] ?? _default.language;
}
