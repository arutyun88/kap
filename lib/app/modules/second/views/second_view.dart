import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:kap/services/settings_service.dart';

@RoutePage()
class SecondView extends StatelessWidget {
  const SecondView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(context.topRoute.name)),
      body: Center(child: Text(SettingsService.environment.name)),
    );
  }
}
