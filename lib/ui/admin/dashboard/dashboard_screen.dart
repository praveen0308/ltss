import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ltss/utils/utils.dart';

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
        create: (context) => DashboardScreenBloc(), child: this);
  }
}

class _DashboardScreenState extends State<DashboardScreen> {
  final PageController _pageController = PageController();
  int _flex = 0;

  void _toggleSecondaryPanel() {
    setState(() {
      _flex = _flex == 0 ? AppConstants.secondaryFrameColSpan : 0;
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surfaceVariant,
      body: BlocBuilder<DashboardScreenBloc, DashboardScreenState>(
        builder: (context, state) {
          _flex = state.view != null ? AppConstants.secondaryFrameColSpan : 0;
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                flex: AppConstants.sideMenuColSpan,
                child: SideMenu(
                  onDashboardItemClick: (int index) {
                    _pageController.jumpToPage(index);
                  },
                ),
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
    );
  }
}
