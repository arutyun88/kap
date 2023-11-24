import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  AuthController(this.context);

  final FocusNode focusNode = FocusNode();

  final BuildContext context;

  final isPhoneNumber = false.obs;

  void onTapToBack() => context.router.pop();

  void onTapToTextField() {
    if (!focusNode.hasFocus) {
      FocusScope.of(context).requestFocus(focusNode);
    }
  }
}
