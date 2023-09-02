import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:kap/app/modules/my_app.dart';
import 'package:kap/config/environment.dart';
import 'package:kap/services/environment_service.dart';
import 'package:kap/services/firebase_service.dart';
import 'package:kap/services/localization_service.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

void mainInit(Environment env) async {
  WidgetsFlutterBinding.ensureInitialized();
  await _initServices(env: env);
  runApp(const MyApp());
}

Future<void> _initServices({required Environment env}) async {
  await EnvironmentService.init(env);
  Hive.init((await path_provider.getApplicationDocumentsDirectory()).path);
  await FirebaseService.init();
  await LocalizationService.init();
}
