import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kap/app/modules/first/controllers/first_controller.dart';
import 'package:kap/app/widgets/app_shader_scaffold.dart';
import 'package:kap/config/l10n/custom_app_localizations.dart';
import 'package:kap/config/palette/palette.dart';
import 'package:kap/config/theme/app_theme.dart';
import 'package:kap/config/theme/typography.dart';
import 'package:kap/services/settings/theme_service.dart';
import 'package:kap/services/widgets_size_service.dart';

@RoutePage()
class FirstEmptyView extends AutoRouter {
  const FirstEmptyView({super.key});
}

@RoutePage()
class FirstView extends StatelessWidget {
  const FirstView({super.key});

  @override
  Widget build(BuildContext context) {
    return AppShaderScaffold(
      body: Scaffold(
        body: GetBuilder(
          init: FirstController(context),
          builder: (controller) => SingleChildScrollView(
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(height: context.mediaQueryPadding.top),
                  ElevatedButton(
                    onPressed: controller.goToSecondPage,
                    child: Text('GO TO SECOND PAGE', style: context.theme.textTheme.through),
                  ),
                  ElevatedButton(
                    onPressed: controller.goToProfilePage,
                    child: Text('GO TO PROFILE', style: context.theme.textTheme.through),
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
                  ...List.generate(
                    5,
                    (index) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Container(
                        height: 100,
                        width: double.infinity,
                        color: Colors.red,
                      ),
                    ),
                  ),
                  const TextField(),
                  ...List.generate(
                    5,
                        (index) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Container(
                        height: 100,
                        width: double.infinity,
                        color: Colors.green,
                      ),
                    ),
                  ),
                  SizedBox(height: WidgetsSizeService.to.bottomBarHeight.value),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
