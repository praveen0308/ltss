part of 'route_imports.dart';

@AutoRouterConfig(replaceInRouteName: 'Screen,Route')
class AppRouter extends $AppRouter {
  @override
  RouteType get defaultRouteType => const RouteType.material();

  @override
  List<AutoRoute> get routes => [
        AutoRoute(initial: true, page: SplashRoute.page),
        AutoRoute(page: DashboardRoute.page),
        AutoRoute(page: UserDashboardRoute.page),
        AutoRoute(page: EnterMobileNumberRoute.page),
        AutoRoute(page: VerifyOtpRoute.page),
        AutoRoute(page: AddUserRoute.page),
        AutoRoute(page: AddFundRequestRoute.page),
        AutoRoute(page: UserDetailRoute.page),
        AutoRoute(page: EditProfileRoute.page),
      ];
}
