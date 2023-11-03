import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kap/app/widgets/app_shader_scaffold.dart';
import 'package:kap/config/l10n/custom_app_localizations.dart';
import 'package:kap/config/palette/palette.dart';
import 'package:kap/services/settings/localization_service.dart';

@RoutePage()
class SecondView extends StatelessWidget {
  const SecondView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppShaderScaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Align(
            alignment: AlignmentDirectional.topCenter,
            child: AppBar(title: Text(context.topRoute.name)),
          ),
          Expanded(
            child: Obx(
              () => Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    context.dictionary.profile,
                    style: context.textTheme.bodyLarge?.copyWith(color: Palette.support.danger),
                  ),
                  ElevatedButton(
                    onPressed: LocalizationService.locale.languageCode != 'ru'
                        ? () => LocalizationService.changeLocale(const Locale('ru'))
                        : null,
                    child: Text(
                      'русский',
                      style: context.textTheme.bodyLarge?.copyWith(color: Palette.support.danger),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: LocalizationService.locale.languageCode != 'en'
                        ? () => LocalizationService.changeLocale(const Locale('en'))
                        : null,
                    child: Text(
                      'english',
                      style: context.textTheme.bodyLarge?.copyWith(color: Palette.support.danger),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () => LocalizationService.changeLocale(null),
                    child: Text(
                      'device',
                      style: context.textTheme.bodyLarge?.copyWith(color: Palette.support.danger),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
