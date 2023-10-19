import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:kap/app/modules/first/controllers/first_controller.dart';
import 'package:kap/config/l10n/custom_app_localizations.dart';
import 'package:kap/config/palette/palette.dart';
import 'package:kap/config/theme/app_theme.dart';
import 'package:kap/config/theme/typography.dart';
import 'package:kap/services/theme_service.dart';

@RoutePage()
class FirstView extends StatelessWidget {
  const FirstView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: FirstController(context),
      builder: (controller) => AnnotatedRegion<SystemUiOverlayStyle>(
        value: Theme.of(context).appBarTheme.systemOverlayStyle ?? SystemUiOverlayStyle.light,
        child: Scaffold(
          body: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ElevatedButton(
                  onPressed: controller.goToSecondPage,
                  child: Text('GO TO SECOND PAGE', style: context.theme.textTheme.through),
                ),
                Text(
                  context.dictionary.language,
                  style: context.theme.textTheme.body.copyWith(color: Palette.main.primary.light),
                ),
                Text(
                  context.dictionary.helloWithUsername('some'),
                  style: context.theme.textTheme.through.copyWith(color: Palette.support.warning.light),
                ),
                ElevatedButton(
                  onPressed: () => ThemeService.to.change(AppTheme.light),
                  child: Text('Light', style: context.theme.textTheme.through),
                ),
                ElevatedButton(
                  onPressed: () => ThemeService.to.change(AppTheme.dark),
                  child: Text('Dark', style: context.theme.textTheme.through),
                ),
                ElevatedButton(
                  onPressed: () => ThemeService.to.change(null),
                  child: Text('Device', style: context.theme.textTheme.through),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
