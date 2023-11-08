import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ltss/repository/repository.dart';
import 'package:ltss/repository/service_repository.dart';
import 'package:ltss/ui/admin/services/pages/charges/charges_page.dart';
import 'package:ltss/ui/admin/services/pages/charges/charges_page_cubit.dart';
import 'package:ltss/ui/admin/services/pages/commission/commissions_page.dart';
import 'package:ltss/ui/admin/services/pages/commission/commissions_page_cubit.dart';
import 'package:ltss/ui/admin/services/pages/service/service_page.dart';
import 'package:ltss/ui/admin/services/pages/service/service_page_cubit.dart';
import 'package:ltss/ui/widgets/view_dashboard_item.dart';

class ServicesScreen extends StatefulWidget {
  const ServicesScreen({super.key});

  @override
  State<ServicesScreen> createState() => _ServicesScreenState();
}

class _ServicesScreenState extends State<ServicesScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Column(
        children: [
          const TabBar(
            tabs: [
              Tab(
                text: "Services",
              ),
              Tab(
                text: "Commissions",
              ),
              Tab(
                text: "Charges",
              ),
            ],
          ),
          Expanded(
            child: TabBarView(
              children: [
                BlocProvider(
                  create: (context) => ServicePageCubit(
                      RepositoryProvider.of<ServiceRepository>(context)),
                  child: const ServicePage(),
                ),
                BlocProvider(
                  create: (context) => CommissionsPageCubit(
                      RepositoryProvider.of<CommissionRepository>(context)),
                  child: const CommissionsPage(),
                ),
                BlocProvider(
                  create: (context) => ChargesPageCubit(
                      RepositoryProvider.of<ChargeRepository>(context))..loadData(),
                  child: const ChargesPage(),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
