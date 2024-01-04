import 'package:auto_route/auto_route.dart';
import 'package:kap/app/modules/country/views/country_view.dart';
import 'package:kap/app/modules/first/views/first_view.dart';
import 'package:kap/app/modules/me/views/me_view.dart';
import 'package:kap/app/modules/profile/views/profile_view.dart';
import 'package:kap/app/modules/root/views/root_view.dart';
import 'package:kap/app/modules/second/views/second_view.dart';

part 'app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'View,Route')
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(
          page: RootRoute.page,
          initial: true,
          children: [
            AutoRoute(
              page: FirstEmptyRoute.page,
              children: [
                AutoRoute(page: FirstRoute.page),
                AutoRoute(page: SecondRoute.page),
              ],
            ),
            AutoRoute(
              page: MeEmptyRoute.page,
              children: [
                AutoRoute(page: MeRoute.page),
                AutoRoute(page: ProfileRoute.page),
              ],
            ),
          ],
        ),
        AutoRoute(page: CountryRoute.page),
      ];
}
