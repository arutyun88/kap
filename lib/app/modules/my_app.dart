import 'package:flutter/material.dart';

import '../../router/app_router.dart';

final _appRouter = AppRouter();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Kap mobile',
      theme: ThemeData(primarySwatch: Colors.blue),
      routerConfig: _appRouter.config(),
    );
  }
}
