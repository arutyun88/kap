import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:kap/router/app_router.dart';

class FirstController extends GetxController {
  final BuildContext context;

  FirstController(this.context);

  void goToSecondPage() => AutoRouter.of(context).push(const SecondRoute());
}
