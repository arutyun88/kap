import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:kap/app/modules/my_app.dart';
import 'package:kap/config/environment.dart';
import 'package:kap/firebase_options.dart';
import 'package:kap/services/environment_service.dart';

void mainInit(Environment env) async {
  await _initServices(env: env);
  runApp(const MyApp());
}

Future<void> _initServices({required Environment env}) async {
  EnvironmentService.init(env);
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
}
