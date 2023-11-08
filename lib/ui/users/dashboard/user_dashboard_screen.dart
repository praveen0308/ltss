import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ltss/local/session_manager.dart';
import 'package:ltss/ui/users/dashboard/user_dashboard_screen_cubit.dart';
import 'package:ltss/ui/widgets/view_error_page.dart';

@RoutePage()
class UserDashboardScreen extends StatefulWidget implements AutoRouteWrapper {
  const UserDashboardScreen({super.key});

  @override
  State<UserDashboardScreen> createState() => _UserDashboardScreenState();

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(
      create: (context) => UserDashboardScreenCubit(
          RepositoryProvider.of<SessionManager>(context)),
      child: this,
    );
  }
}

class _UserDashboardScreenState extends State<UserDashboardScreen> {
  int currentPageIndex = 0;

  @override
  void initState() {
    context.read<UserDashboardScreenCubit>().loadUI();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: BlocConsumer<UserDashboardScreenCubit, UserDashboardScreenState>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state is LoadingUI) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is LoadUIFailed) {
          return ErrorPageView(msg: state.msg);
        }
        if (state is UILoaded) {

          return Scaffold(
            bottomNavigationBar: NavigationBar(
              onDestinationSelected: (int index) {
                // setState(() {
                //   currentPageIndex = index;
                // });
                context.read<UserDashboardScreenCubit>().switchToPage(index);
              },
              selectedIndex: state.activeIndex,
              destinations: state.navItems,
            ),
            body: state.pages[state.activeIndex],
          );
        }
        return Container();
      },
    ));
  }
}
