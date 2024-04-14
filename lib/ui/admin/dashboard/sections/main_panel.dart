import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ltss/repository/repository.dart';
import 'package:ltss/ui/admin/banks/manage_banks_cubit.dart';
import 'package:ltss/ui/admin/banks/manage_banks_screen.dart';
import 'package:ltss/ui/admin/fund_requests/manage_fund_requests.dart';
import 'package:ltss/ui/admin/fund_requests/manage_fund_requests_cubit.dart';
import 'package:ltss/ui/admin/home/home.dart';
import 'package:ltss/ui/admin/manage_dmt/manage_dmt.dart';
import 'package:ltss/ui/admin/report/report.dart';
import 'package:ltss/ui/admin/services/services.dart';
import 'package:ltss/ui/admin/users/user_list_screen_cubit.dart';
import 'package:ltss/ui/admin/users/users.dart';
import 'package:ltss/ui/admin/wallet/wallet.dart';
import 'package:ltss/ui/admin/wallet/wallet_screen_cubit.dart';
import 'package:ltss/utils/utils.dart';

class MainPanel extends StatefulWidget {
  final PageController pageController;
  final List<Widget> pages;

  const MainPanel({super.key, required this.pageController, required this.pages});

  @override
  State<MainPanel> createState() => _MainPanelState();
}

class _MainPanelState extends State<MainPanel> {
  @override
  void initState() {
    widget.pages.removeLast();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(8)),
      child: PageView(
        controller: widget.pageController,
        children: widget.pages,
      ),
    );
  }
}
