import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kap/router/app_router.dart';

class MeController extends GetxController {
  final BuildContext context;

  MeController(this.context);

  void goToProfilePage() => AutoRouter.of(context).push(const ProfileRoute());
}
