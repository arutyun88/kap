import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kap/app/modules/first/controllers/first_controller.dart';
import 'package:kap/app/widgets/app_button.dart';
import 'package:kap/app/widgets/app_shader_scaffold.dart';
import 'package:kap/config/l10n/custom_app_localizations.dart';
import 'package:kap/config/palette/palette.dart';
import 'package:kap/config/theme/app_theme.dart';
import 'package:kap/services/auth_service.dart';
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
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Row(
                      children: [
                        Flexible(child: AppButton.accent(onTap: controller.goToSecondPage, title: 'GO TO SECOND PAGE')),
                        Flexible(child: AppButton.accent(onTap: controller.goToProfilePage, title: 'GO TO PROFILE')),
                      ],
                    ),
                  ),
                  Text(
                    context.dictionary.language,
                    style: context.theme.textTheme.bodyMedium?.copyWith(color: Palette.main.primary.light),
                  ),
                  Text(
                    context.dictionary.helloWithUsername('some'),
                    style: context.theme.textTheme.bodySmall?.copyWith(color: Palette.support.warning.light),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Row(
                      children: [
                        Flexible(
                          child: ThemeService.to.theme.value == AppTheme.light
                              ? AppButton.accent(
                                  onTap: () => ThemeService.to.change(AppTheme.light),
                                  title: 'Light',
                                )
                              : AppButton.secondary(
                                  onTap: () => ThemeService.to.change(AppTheme.light),
                                  title: 'Light',
                                ),
                        ),
                        Flexible(
                          child: ThemeService.to.theme.value == AppTheme.dark
                              ? AppButton.accent(
                                  onTap: () => ThemeService.to.change(AppTheme.dark),
                                  title: 'Dark',
                                )
                              : AppButton.secondary(
                                  onTap: () => ThemeService.to.change(AppTheme.dark),
                                  title: 'Dark',
                                ),
                        ),
                      ],
                    ),
                  ),
                  AppButton.secondary(
                    onTap: () => ThemeService.to.change(null),
                    title: 'Device',
                  ),
                  SizedBox(height: WidgetsSizeService.to.bottomBarHeight.value),
                  Obx(
                    () => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Column(
                        children: [
                          Text(
                            'authorized: ${AuthService.to.isAuthorized.value}',
                            style: context.theme.textTheme.bodySmall,
                          ),
                          AuthService.to.isAuthorized.value
                              ? AppButton.secondary(
                                  onTap: () => AuthService.to.isAuthorized.value = false,
                                  title: 'LogOut',
                                )
                              : AppButton.accent(
                                  onTap: () => AuthService.to.isAuthorized.value = true,
                                  title: 'LogIn',
                                ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
