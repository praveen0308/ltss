import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:ltss/local/session_manager.dart';
import 'package:ltss/repository/bank_repository.dart';
import 'package:ltss/routes/route_imports.gr.dart';
import 'package:ltss/ui/admin/banks/manage_banks_cubit.dart';
import 'package:ltss/ui/admin/banks/manage_banks_screen.dart';
import 'package:ltss/ui/admin/report/report_screen.dart';
import 'package:ltss/utils/utils.dart';
import 'package:tuple/tuple.dart';

import '../../../repository/dmt_repository.dart';
import '../../../repository/fund_request_repository.dart';
import '../../../repository/user_repository.dart';
import '../../../repository/wallet_repository.dart';
import '../fund_requests/manage_fund_requests.dart';
import '../fund_requests/manage_fund_requests_cubit.dart';
import '../home/home_screen.dart';
import '../manage_dmt/manage_dmt.dart';
import '../services/services_screen.dart';
import '../users/user_list_screen.dart';
import '../wallet/wallet_screen.dart';
import 'bloc/dashboard_screen_bloc.dart';
import 'sections/main_panel.dart';
import 'sections/secondary_panel.dart';
import 'sections/side_menu.dart';

@RoutePage()
class DashboardScreen extends StatefulWidget implements AutoRouteWrapper {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(
        create: (context) => DashboardScreenBloc(RepositoryProvider.of<SessionManager>(context)), child: this);
  }
}

class _DashboardScreenState extends State<DashboardScreen> {
  final PageController _pageController = PageController();
  int _flex = 0;
  final List<Tuple3<String, IconData, Widget>> _pages =
      List.empty(growable: true);

  void _toggleSecondaryPanel() {
    setState(() {
      _flex = _flex == 0 ? AppConstants.secondaryFrameColSpan : 0;
    });
  }

  @override
  void initState() {
    _pages.add(const Tuple3("Home", Icons.dashboard_rounded, HomeScreen()));
    _pages.add(Tuple3(
        "Fund Requests", Icons.message, ManageFundRequestsScreen.create()));
    _pages.add(const Tuple3("DMT", Icons.list_alt_rounded, ManageDMTScreen()));
    _pages.add(Tuple3("Distributors", Icons.account_tree_rounded,
        UserListScreen.create(role: UserRole.distributor)));
    _pages.add(Tuple3("Retailers", Icons.photo_camera_front_rounded,
        UserListScreen.create(role: UserRole.retailer)));
    _pages.add(Tuple3("Wallet", Icons.wallet_rounded, WalletScreen.create()));
    _pages.add(const Tuple3(
        "Services", Icons.miscellaneous_services_rounded, ServicesScreen()));
    _pages.add(
        Tuple3("Banks", Icons.account_balance, ManageBanksScreen.create()));
    _pages.add(const Tuple3("Report", Icons.list_alt_rounded, ReportScreen()));
    _pages.add(Tuple3("Log Out", Icons.logout_rounded, Container()));

    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _dialogStack() async {
    stackDialog({
      required Alignment alignment,
      required String tag,
      double width = double.infinity,
      double height = double.infinity,
    }) async {
      var result = await SmartDialog.show(
        tag: tag,
        alignment: alignment,
        builder: (_) {
          return AlertDialog(
            title: const Text('Log Out'),
            content: const Text('Are you sure you want to logout?'),
            actions: [
              TextButton(
                onPressed: () {
                  SmartDialog.dismiss(tag: "logoutAdmin");
                },
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () {
                  SmartDialog.dismiss(tag: "logoutAdmin", result: true);
                },
                child: const Text('Yes'),
              ),
            ],
          );
        },
      );

      if (result != null && result == true) {
        if(context.mounted) context.read<DashboardScreenBloc>().add(LogOut());
      }
    }

    await stackDialog(
        tag: 'logoutAdmin',
        width: MediaQuery.of(context).size.width * 0.3,
        alignment: Alignment.center);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surfaceVariant,
      body: BlocListener<DashboardScreenBloc, DashboardScreenState>(
  listener: (context, state) {
    if(state is LogOutSuccessfully){
      AutoRouter.of(context).pushAndPopUntil(const EnterMobileNumberRoute(), predicate:(Route<dynamic> route) => false );
    }
  },
  child: BlocBuilder<DashboardScreenBloc, DashboardScreenState>(
        builder: (context, state) {
          _flex = state.view != null ? AppConstants.secondaryFrameColSpan : 0;
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                flex: AppConstants.sideMenuColSpan,
                child: SideMenu(
                    navItems: _pages
                        .mapIndexed((e, i) => ListTile(
                              title: Text(e.item1),
                              leading: Icon(e.item2),
                              onTap: () {
                                if ((_pages.length - 1) == i) {
                                  _dialogStack();
                                }
                                _pageController.jumpToPage(i);
                              },
                            ))
                        .toList()),
              ),
              Expanded(
                flex: AppConstants.mainFrameColSpan,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(4),
                      margin: const EdgeInsets.only(top: 8, right: 8, left: 8),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5)),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text("Welcome, Admin"),
                          Divider(
                            thickness: 10,
                            indent: 10,
                          ),
                          Icon(Icons.notifications)
                        ],
                      ),
                    ),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            flex: AppConstants.mainFrameColSpan - _flex,
                            child: MainPanel(
                              pageController: _pageController,
                              pages: _pages.map((e) => e.item3).toList(),
                            ),
                          ),
                          Expanded(
                            flex: _flex,
                            child: Visibility(
                                visible: _flex != 0,
                                child: SecondaryPanel(
                                  body: state.view,
                                )),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          );
        },
      ),
),
    );
  }
}
