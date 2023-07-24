import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:kap/config/l10n/custom_app_localizations.dart';
import 'package:kap/router/app_router.dart';

@RoutePage()
class FirstView extends StatelessWidget {
  const FirstView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(context.topRoute.name)),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton(
              onPressed: () => AutoRouter.of(context).push(const SecondRoute()),
              child: const Text('GO TO SECOND PAGE'),
            ),
            Text(context.dictionary.language),
            Text(context.dictionary.helloWithUsername('some')),
          ],
        ),
      ),
    );
  }
}
