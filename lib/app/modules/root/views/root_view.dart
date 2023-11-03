import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kap/app/widgets/app_bottom_navigation_bar.dart';
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
        return AnnotatedRegion<SystemUiOverlayStyle>(
          value: Theme.of(context).appBarTheme.systemOverlayStyle ?? SystemUiOverlayStyle.light,
          child: Scaffold(
            body: Stack(
              children: [
                child,
                AppBottomNavigationBar(
                  onTapToItem: (index) => tabController.index = index,
                  selectedIndex: tabController.index,
                  icons: const [Icons.home, Icons.person],
                  floatingActionButtonIcon: Icons.add,
                  floatingActionButtonOnTap: () {},
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
