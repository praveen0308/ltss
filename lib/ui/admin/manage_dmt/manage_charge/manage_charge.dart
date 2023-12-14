import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ltss/base/base.dart';
import 'package:ltss/ui/admin/manage_dmt/charge_view/charge_view.dart';
import 'package:ltss/ui/admin/manage_dmt/charge_view/charge_view_cubit.dart';
import 'package:ltss/ui/widgets/view_error_page.dart';
import 'package:ltss/ui/widgets/view_loading.dart';

import '../../dashboard/bloc/dashboard_screen_bloc.dart';
import 'manage_charge_cubit.dart';

@RoutePage()
class ManageChargeScreen extends StatefulWidget {
  final int serviceId;

  const ManageChargeScreen({super.key, required this.serviceId});

  @override
  State<ManageChargeScreen> createState() => _ManageChargeScreenState();
}

class _ManageChargeScreenState extends State<ManageChargeScreen> {
  @override
  void initState() {
    context.read<ManageChargeCubit>().fetchCharges(widget.serviceId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text("Manage Charge"),
        actions: [
          IconButton(
              onPressed: () {
                context.read<DashboardScreenBloc>().add(Empty());
              },
              icon: const Icon(Icons.close))
        ],
      ),
      body: BlocConsumer<ManageChargeCubit, ManageChargeState>(
          builder: (context, state) {
            switch (state) {
              case ManageChargeInitial():
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
                    var charge = state.charges[index];
                    return BlocProvider(
                      create: (context) => ChargeViewCubit(
                          RepositoryProvider.of<ChargeRepository>(context)),
                      child: ChargeView(chargeEntity: charge),
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return const Divider();
                  },
                  itemCount: state.charges.length,
                );
            }
          },
          listener: (context, state) {}),
    ));
  }
}
