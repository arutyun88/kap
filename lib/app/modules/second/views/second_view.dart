import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kap/config/l10n/custom_app_localizations.dart';
import 'package:kap/services/settings/localization_service.dart';

@RoutePage()
class SecondView extends StatelessWidget {
  const SecondView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(context.topRoute.name)),
      body: Center(
        child: Obx(
          () => Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(context.dictionary.profile),
              ElevatedButton(
                onPressed: LocalizationService.locale.languageCode != 'ru'
                    ? () => LocalizationService.changeLocale(const Locale('ru'))
                    : null,
                child: const Text('русский'),
              ),
              ElevatedButton(
                onPressed: LocalizationService.locale.languageCode != 'en'
                    ? () => LocalizationService.changeLocale(const Locale('en'))
                    : null,
                child: const Text('english'),
              ),
              ElevatedButton(
                onPressed: () => LocalizationService.changeLocale(null),
                child: const Text('device'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
