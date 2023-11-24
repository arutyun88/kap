import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kap/app/modules/me/controllers/me_controller.dart';

@RoutePage()
class MeEmptyView extends AutoRouter {
  const MeEmptyView({super.key});
}

@RoutePage()
class MeView extends StatelessWidget {
  const MeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: MeController(context),
      builder: (controller) {
        return Scaffold(
          body: Center(
            child: ElevatedButton(
              onPressed: controller.goToProfilePage,
              child: Text('GO TO PROFILE', style: context.theme.textTheme.bodyMedium),
            ),
          ),
        );
      },
    );
  }
}
