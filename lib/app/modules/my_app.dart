import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:kap/config/theme/app_theme.dart';
import 'package:kap/router/app_router.dart';
import 'package:kap/services/localization_service.dart';

final _appRouter = AppRouter();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => MaterialApp.router(
        title: 'Kap mobile',
        theme: SchedulerBinding.instance.platformDispatcher.platformBrightness == Brightness.dark
            ? AppTheme.dark
            : AppTheme.light,
        routerConfig: _appRouter.config(),
        locale: LocalizationService.locale,
        supportedLocales: AppLocalizations.supportedLocales,
        localizationsDelegates: Get.find<LocalizationService>().delegate,
      ),
    );
  }
}
