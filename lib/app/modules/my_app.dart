import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kap/config/l10n/custom_app_localizations.dart';
import 'package:kap/router/app_router.dart';
import 'package:kap/services/settings/localization_service.dart';
import 'package:kap/services/settings/theme_service.dart';

final _appRouter = AppRouter();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => MaterialApp.router(
        title: 'Kap mobile',
        theme: ThemeService.to.theme.value,
        routerConfig: _appRouter.config(),
        // locale: LocalizationService.locale,
        supportedLocales: CustomAppLocalizations.supportedLocales,
        localizationsDelegates: CustomAppLocalizations.localizationsDelegates,
      ),
    );
  }
}
