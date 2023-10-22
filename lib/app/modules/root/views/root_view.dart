import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:kap/router/app_router.dart';

@RoutePage()
class RootView extends StatelessWidget {
  const RootView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AutoTabsRouter.tabBar(
      animatePageTransition: false,
      physics: const NeverScrollableScrollPhysics(),
      routes: const [FirstRoute(), MeRoute()],
      builder: (context, child, tabController) {
        return Scaffold(
          body: Stack(
            children: [
              child,
              Align(
                alignment: AlignmentDirectional.bottomCenter,
                child: BottomNavigationBar(
                  onTap: (index) => tabController.index = index,
                  currentIndex: tabController.index,
                  items: const [
                    BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
                    BottomNavigationBarItem(icon: Icon(Icons.person), label: ''),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
