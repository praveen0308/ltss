import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ltss/repository/repository.dart';
import 'package:ltss/ui/admin/home/home.dart';
import 'package:ltss/ui/admin/report/report.dart';
import 'package:ltss/ui/admin/services/services.dart';
import 'package:ltss/ui/admin/users/user_list_screen_cubit.dart';
import 'package:ltss/ui/admin/users/users.dart';
import 'package:ltss/ui/admin/wallet/wallet.dart';
import 'package:ltss/ui/admin/wallet/wallet_screen_cubit.dart';
import 'package:ltss/utils/utils.dart';

class MainPanel extends StatefulWidget {
  final PageController pageController;

  const MainPanel({super.key, required this.pageController});

  @override
  State<MainPanel> createState() => _MainPanelState();
}

class _MainPanelState extends State<MainPanel> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(8)),
      child: PageView(
        controller: widget.pageController,
        children:  [
          const HomeScreen(),
          BlocProvider(
            create: (context) => UserListScreenCubit(
                RepositoryProvider.of<UserRepository>(context)),
            child: const UserListScreen(type: UserRole.distributor),
          ),BlocProvider(
            create: (context) => UserListScreenCubit(
                RepositoryProvider.of<UserRepository>(context)),
            child: const UserListScreen(type: UserRole.retailer),
          ),BlocProvider(
            create: (context) => UserListScreenCubit(
                RepositoryProvider.of<UserRepository>(context)),
            child: const UserListScreen(type: UserRole.vendor),
          ),BlocProvider(
            create: (context) => UserListScreenCubit(
                RepositoryProvider.of<UserRepository>(context)),
            child: const UserListScreen(type: UserRole.customer),
          ),BlocProvider(
            create: (context) => WalletScreenCubit(
                RepositoryProvider.of<WalletRepository>(context),
                RepositoryProvider.of<DMTRepository>(context),

            )..loadWalletBalance(),
            child: const WalletScreen(),
          ),
          const ServicesScreen(),
          const ReportScreen(),
        ],
      ),
    );
  }
}
