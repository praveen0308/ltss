import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ltss/base/base.dart';
import 'package:ltss/models/enums.dart';
import 'package:ltss/ui/admin/dashboard/bloc/dashboard_screen_bloc.dart';
import 'package:ltss/ui/admin/manage_dmt/manage_vendors/manage_vendors.dart';
import 'package:ltss/ui/admin/manage_dmt/manage_vendors/manage_vendors_cubit.dart';
import 'package:ltss/ui/admin/manage_dmt/transactions/dmt_transactions.dart';
import 'package:ltss/ui/admin/manage_dmt/transactions/dmt_transactions_cubit.dart';
import 'package:ltss/ui/widgets/widgets.dart';

class ManageDMTScreen extends StatefulWidget {
  const ManageDMTScreen({super.key});

  @override
  State<ManageDMTScreen> createState() => _ManageDMTScreenState();
}

class _ManageDMTScreenState extends State<ManageDMTScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          "Manage DMT",
          style: Theme
              .of(context)
              .textTheme
              .titleLarge,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ItemView("Manage\nCommission", Icons.percent_rounded,
                    Colors.green, () {
                      context.read<DashboardScreenBloc>().add(ToggleManageCommission(AppService.dmt.id));
                    }),
              ),

              ItemView("Manage\nCharges", Icons.local_offer_rounded,
                  Colors.blue, () {
                    context.read<DashboardScreenBloc>().add(ToggleManageCharges(AppService.dmt.id));
                  }),
            ],
          ),
        ),
        Expanded(
          child: DefaultTabController(
            length: 2,
            child: Column(
              children: [
                const TabBar(
                  tabs: [
                    Tab(
                      text: "Transactions",
                    ),
                    Tab(
                      text: "Vendors",
                    ),
                  ],
                ),
                Expanded(
                  child: TabBarView(
                    children: [
                      BlocProvider(
                        create: (context) => DmtTransactionsCubit(RepositoryProvider.of<DMTRepository>(context)),
                        child: const DMTTransactionsScreen(),
                      ),
                      BlocProvider(
                        create: (context) => ManageVendorsCubit(RepositoryProvider.of<UserRepository>(context)),
                        child: const ManageDMTVendorsScreen(),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget ItemView(String title, IconData icon, Color color,
      VoidCallback onClick) {
    return GestureDetector(
      onTap: onClick,
      child: Container(
        width: 150,
        height: 60,
        decoration:
        BoxDecoration(color: color, borderRadius: BorderRadius.circular(5)),
        child: Row(
          children: [
            Expanded(
                flex: 1,
                child: Container(
                    decoration: BoxDecoration(
                        color: Color.lerp(color, Colors.white, 0.4),
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(5),
                            bottomLeft: Radius.circular(5))),
                    child: Center(
                        child: Icon(
                          icon,
                          color: Colors.white,
                        )))),
            Expanded(
                flex: 2,
                child: Center(
                    child: Text(
                      title,
                      style: const TextStyle(color: Colors.white),
                    ))),
          ],
        ),
      ),
    );
  }
}
