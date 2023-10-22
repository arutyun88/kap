import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kap/app/modules/profile/controllers/profile_controller.dart';

@RoutePage()
class ProfileEmptyView extends AutoRouter {
  const ProfileEmptyView({super.key});
}

@RoutePage()
class ProfileView extends StatelessWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: ProfileController(),
      builder: (controller) {
        return Scaffold(
          body: Center(
            child: Text('Profile View', style: context.theme.textTheme.bodyLarge?.copyWith(color: Colors.red)),
          ),
        );
      },
    );
  }
}
