import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:kap/config/app_theme.dart';
import 'package:kap/router/app_router.dart';
import 'package:kap/services/localization_service.dart';
import 'package:kap/services/settings_service.dart';

final _appRouter = AppRouter();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => MaterialApp.router(
        title: 'Kap mobile',
        theme: AppTheme.dark,
        routerConfig: _appRouter.config(),
        locale: SettingsService.localization.locale,
        supportedLocales: AppLocalizations.supportedLocales,
        localizationsDelegates: Get.find<LocalizationService>().delegate,
      ),
    );
  }
}

