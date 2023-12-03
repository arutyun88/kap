import 'dart:developer';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:kap/app/modules/my_app.dart';
import 'package:kap/config/environment.dart';
import 'package:kap/datasource/localization/firebase_localization_datasource.dart';
import 'package:kap/datasource/localization/hive_localization_datasource.dart';
import 'package:kap/repositories/localization_repository.dart';
import 'package:kap/services/environment_service.dart';
import 'package:kap/services/firebase_service.dart';
import 'package:kap/services/launch_tracker_service.dart';
import 'package:kap/services/auth_service.dart';
import 'package:kap/services/settings/localization_service.dart';
import 'package:kap/services/settings/observer_service.dart';
import 'package:kap/services/storage/storage_service.dart';
import 'package:kap/services/settings/theme_service.dart';
import 'package:kap/services/widgets_size_service.dart';

void mainInit(Environment env) async {
  WidgetsFlutterBinding.ensureInitialized();
  await _initServices(env: env);
  runApp(const MyApp());
}

Future<void> _initServices({required Environment env}) async {
  LaunchTrackerService.init();
  LaunchTrackerService.to.startService('EnvironmentService');
  await EnvironmentService.init(env);
  LaunchTrackerService.to.stopService('EnvironmentService');
  LaunchTrackerService.to.startService('StorageService');
  await StorageService.init();
  LaunchTrackerService.to.stopService('StorageService');
  LaunchTrackerService.to.startService('LoggingService');
  await AuthService.init();
  LaunchTrackerService.to.stopService('LoggingService');
  LaunchTrackerService.to.startService('ThemeService');
  await ThemeService.init();
  LaunchTrackerService.to.stopService('ThemeService');
  LaunchTrackerService.to.startService('ObserverService');
  ObserverService.init();
  LaunchTrackerService.to.stopService('ObserverService');
  LaunchTrackerService.to.startService('FirebaseService');
  await FirebaseService.init();
  LaunchTrackerService.to.stopService('FirebaseService');
  LaunchTrackerService.to.startService('LocalizationService');
  await LocalizationService.init(
    LocalizationRepository(
      localLocalizationDatasource: const HiveLocalizationDatasource(),
      remoteLocalizationDatasource: FirebaseLocalizationDatasource(firebaseDatabase: FirebaseDatabase.instance),
    ),
  );
  LaunchTrackerService.to.stopService('LocalizationService');
  LaunchTrackerService.to.startService('WidgetsSizeService');
  WidgetsSizeService.init();
  LaunchTrackerService.to.stopService('WidgetsSizeService');

  log(LaunchTrackerService.to.toString());
}
