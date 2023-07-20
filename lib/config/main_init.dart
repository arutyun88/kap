import 'package:flutter/material.dart';
import 'package:kap/app/modules/my_app.dart';
import 'package:kap/config/environment.dart';

void mainInit(Environment env) async {
  runApp(MyApp(title: env.name));
}
