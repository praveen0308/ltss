import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ltss/base/base.dart';
import 'package:ltss/ui/users/pages/account/account_page.dart';
import 'package:ltss/ui/users/pages/account/account_page_cubit.dart';
import 'package:ltss/ui/users/pages/home/home_page.dart';
import 'package:ltss/ui/users/pages/home/home_page_cubit.dart';
import 'package:ltss/ui/users/pages/requests/fund_requests_cubit.dart';
import 'package:ltss/ui/users/pages/requests/view/request_page_cubit.dart';
import 'package:ltss/ui/users/pages/transactions/transactions_page.dart';
import 'package:ltss/ui/users/pages/transactions/transactions_page_cubit.dart';
import 'package:ltss/ui/users/pages/user_list/user_list_cubit.dart';
import 'package:ltss/ui/users/pages/user_list/user_list_page.dart';
import 'package:ltss/utils/user_type.dart';

import '../pages/requests/fund_requests_page.dart';

part 'user_dashboard_screen_state.dart';

class UserDashboardScreenCubit extends BaseCubit<UserDashboardScreenState> {
  final SessionManager _sessionManager;

  UserDashboardScreenCubit(this._sessionManager)
      : super(UserDashboardScreenInitial());

  Future<void> loadUI() async {
    emit(LoadingUI());
    var roleId = await _sessionManager.getRoleId();

    var navHome = const NavigationDestination(
      selectedIcon: Icon(Icons.home),
      icon: Icon(Icons.home_outlined),
      label: 'Home',
    );
    var navTransactions = const NavigationDestination(
      selectedIcon: Icon(Icons.list_rounded),
      icon: Icon(Icons.list_alt_outlined),
      label: 'Transactions',
    );
    var navUserList = NavigationDestination(
      selectedIcon: const Icon(Icons.people_rounded),
      icon: const Icon(Icons.people_outline_rounded),
      label: roleId == UserRole.retailer.roleId ? 'Customers' : 'Retailers',
    );
    var navAccount = const NavigationDestination(
      selectedIcon: Icon(Icons.account_circle_rounded),
      icon: Icon(Icons.account_circle_outlined),
      label: 'Account',
    );
    var navRequests = const NavigationDestination(
      selectedIcon: Icon(Icons.message),
      icon: Icon(Icons.message_outlined),
      label: 'Requests',
    );

    var homePage = BlocProvider(
      create: (context) => HomePageCubit(instanceOf<SessionManager>(context),
          instanceOf<UserRepository>(context)),
      child: const HomePage(),
    );
    var transactionPage = BlocProvider(
      create: (context) => TransactionsPageCubit(
        instanceOf<DMTRepository>(context),
        instanceOf<SessionManager>(context)
      ),
      child: const TransactionsPage(),
    );
    var accountPage = BlocProvider(
      create: (context) => AccountPageCubit(instanceOf<SessionManager>(context)),
      child: const AccountPage(),
    );
    var requestsPage = MultiBlocProvider(
      providers: [
        BlocProvider<RequestPageCubit>(
          create: (BuildContext context) =>
              RequestPageCubit(instanceOf<FundRequestRepository>(context)),
        ),
        BlocProvider<FundRequestsCubit>(
          create: (BuildContext context) =>
              FundRequestsCubit(instanceOf<SessionManager>(context)),
        ),
      ],
      child: const FundRequestsPage(),
    );
    var userListPage = BlocProvider(
      create: (context) => UserListCubit(instanceOf<UserRepository>(context),
          instanceOf<SessionManager>(context)),
      child: UserListPage(
          userType: roleId == UserRole.retailer.roleId
              ? UserRole.customer
              : UserRole.retailer),
    );

    if (roleId == UserRole.distributor.roleId) {
      var navItems = [navHome, navUserList, navRequests, navAccount];
      var pages = [homePage, userListPage, requestsPage, accountPage];
      emit(UILoaded(navItems: navItems, pages: pages, activeIndex: 0));
    } else if (roleId == UserRole.retailer.roleId) {
      var navItems = [
        navHome,
        navTransactions,
        navUserList,
        navRequests,
        navAccount
      ];
      var pages = [
        homePage,
        transactionPage,
        userListPage,
        requestsPage,
        accountPage
      ];
      emit(UILoaded(navItems: navItems, pages: pages, activeIndex: 0));
    } else if (roleId == UserRole.vendor.roleId) {
      var navItems = [navHome, navTransactions, navRequests, navAccount];
      var pages = [homePage, transactionPage, requestsPage, accountPage];
      emit(UILoaded(navItems: navItems, pages: pages, activeIndex: 0));
    }
  }

  void switchToPage(int index) {
    emit((state as UILoaded).copyWith(activeIndex: index));
  }
}
