import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ltss/base/base.dart';
import 'package:ltss/ui/admin/manage_dmt/commission_view/commission_view.dart';
import 'package:ltss/ui/admin/manage_dmt/commission_view/commission_view_cubit.dart';
import 'package:ltss/ui/admin/manage_dmt/manage_commission/manage_commission_cubit.dart';
import 'package:ltss/ui/widgets/view_error_page.dart';
import 'package:ltss/ui/widgets/view_loading.dart';

import '../../dashboard/bloc/dashboard_screen_bloc.dart';

@RoutePage()
class ManageCommissionScreen extends StatefulWidget {
  final int serviceId;

  const ManageCommissionScreen({super.key, required this.serviceId});

  @override
  State<ManageCommissionScreen> createState() => _ManageCommissionScreenState();
}

class _ManageCommissionScreenState extends State<ManageCommissionScreen> {
  @override
  void initState() {
    context.read<ManageCommissionCubit>().fetchCommissions(widget.serviceId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text("Manage Commission"),
        actions: [
          IconButton(
              onPressed: () {
                context.read<DashboardScreenBloc>().add(Empty());
              },
              icon: const Icon(Icons.close))
        ],
      ),
      body: BlocConsumer<ManageCommissionCubit, ManageCommissionState>(
          builder: (context, state) {
            switch (state) {
              case ManageCommissionInitial():
                return Container();
              case LoadingData():
                return const LoadingView();
              case LoadDataFailed():
                return ErrorPageView(
                  msg: state.msg,
                );
              case ReceivedData():
                return ListView.separated(
                  itemBuilder: (context, index) {
                    var commission = state.commissions[index];
                    return BlocProvider(
                      create: (context) => CommissionViewCubit(
                          RepositoryProvider.of<CommissionRepository>(context)),
                      child: CommissionView(commissionEntity: commission),
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return const Divider();
                  },
                  itemCount: state.commissions.length,
                );
            }
          },
          listener: (context, state) {}),
    ));
  }
}
