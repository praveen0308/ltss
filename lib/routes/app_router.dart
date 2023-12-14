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
        AutoRoute(page: MyProfileRoute.page),
        AutoRoute(page: FundRequestDetailRoute.page),
        AutoRoute(page: DMTRoute.page),
        AutoRoute(page: SelectCustomerRoute.page),
        AutoRoute(page: SelectBeneficiaryRoute.page),
        AutoRoute(page: AddCustomerRoute.page),
        AutoRoute(page: AddBeneficiaryRoute.page),
        AutoRoute(page: SearchCustomerRoute.page),
        AutoRoute(page: DMTCheckoutRoute.page),
        AutoRoute(page: TransactionSuccessRoute.page),
        AutoRoute(page: KYCFormPage.page),
        AutoRoute(page: TNCFormRoute.page),
      ];
}
