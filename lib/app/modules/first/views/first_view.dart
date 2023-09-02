import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:kap/app/modules/first/controllers/first_controller.dart';
import 'package:kap/config/l10n/custom_app_localizations.dart';
import 'package:ui_kit/ui_kit.dart';

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
                  child: Text('GO TO SECOND PAGE', style: context.theme.textTheme.lineThroughXL),
                ),
                Text(
                  context.dictionary.language,
                  style: context.theme.textTheme.bodyLightXL.copyWith(color: Palette.mainPalette.primary.tone80),
                ),
                Text(
                  context.dictionary.helloWithUsername('some'),
                  style: context.theme.textTheme.lineThroughXS.copyWith(color: Palette.neutralPalette.text.tone50),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
