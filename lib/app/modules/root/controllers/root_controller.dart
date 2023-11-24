import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kap/app/modules/auth/views/auth_view.dart';
import 'package:kap/services/auth_service.dart';

class RootController extends GetxController {
  RootController(this.context, this.tabController);

  final BuildContext context;
  final TabController tabController;

  void onTapToTab(int index) async {
    if (tabController.index == index) return;
    if (AuthService.to.isAuthorized.value) {
      tabController.index = index;
    } else {
      await AuthView.show(context);
    }
  }

  void floatingActionButtonOnTap() async {
    if (AuthService.to.isAuthorized.value) {
    } else {
      await AuthView.show(context);
    }
  }
}
