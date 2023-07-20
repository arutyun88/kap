import 'package:auto_route/auto_route.dart';
import 'package:kap/app/modules/first/views/first_view.dart';
import 'package:kap/app/modules/second/views/second_view.dart';

part 'app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'View,Route')
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: FirstRoute.page, initial: true),
        AutoRoute(page: SecondRoute.page),
      ];
}
