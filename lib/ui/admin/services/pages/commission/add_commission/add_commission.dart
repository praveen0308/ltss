import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ltss/models/api/entity/commission_entity.dart';
import 'package:ltss/models/api/entity/service_entity.dart';
import 'package:ltss/ui/admin/dashboard/bloc/dashboard_screen_bloc.dart';
import 'package:ltss/ui/widgets/view_error_page.dart';
import 'package:ltss/ui/widgets/widgets.dart';
import 'package:ltss/utils/ext_methods.dart';
import 'package:ltss/utils/operations.dart';
import 'package:toggle_switch/toggle_switch.dart';

import 'add_commission_cubit.dart';

class AddCommissionPage extends StatefulWidget {
  final CommissionEntity? commissionEntity;

  const AddCommissionPage({super.key, this.commissionEntity});

  @override
  State<AddCommissionPage> createState() => _AddCommissionPageState();
}

class _AddCommissionPageState extends State<AddCommissionPage> {
  final DropdownFieldViewController<ServiceEntity> _services =
      DropdownFieldViewController<ServiceEntity>();
  final _name = TextEditingController();
  final _value = TextEditingController();
  CommissionEntity? _commission;
  var isActive = true;
  var operation = Operations.add;

  @override
  void initState() {
    if (widget.commissionEntity != null) {
      _commission = widget.commissionEntity!;
      operation = Operations.update;

      _name.text = _commission?.name ?? "";
      _value.text = _commission?.value ?? "";
      isActive = _commission?.isActive==true;
    }
    context.read<AddCommissionCubit>().loadServices();
    super.initState();
  }

  @override
  void dispose() {
    _name.dispose();
    _value.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${operation.isAdd() ? "Add" : "Update"} Commission"),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
              onPressed: () {
                context.read<DashboardScreenBloc>().add(Empty());
              },
              icon: const Icon(Icons.close))
        ],
      ),
      body: BlocConsumer<AddCommissionCubit, AddCommissionState>(
          builder: (context, state) {
        if (state.status.isInitializing) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state.status.isInitializationFailed) {
          return ErrorPageView(msg: state.msg);
        }
        if (state.status.isInitializationSuccessful) {
          _services.setDropdownItems(state.services);
          if(_commission != null){
            var service = state.services
                ?.firstWhere((element) => element.id == _commission?.serviceId);
            _services.setDropdownValue(service);
          }

        }
        return Column(
          children: [
            DropdownFieldView<ServiceEntity>(
              controller: _services,
              onChanged: (d) {},
              label: "Service",
            ),
            TextInputFieldView(label: "Name", textEditingController: _name),
            TextInputFieldView(label: "Value", textEditingController: _value),
            const SizedBox(height: 16,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Is Active"),
                ToggleSwitch(
                  minWidth: 70.0,
                  cornerRadius: 10.0,
                  activeBgColors: [
                    [Colors.red[800]!],
                    [Colors.green[800]!]
                  ],
                  activeFgColor: Colors.white,
                  inactiveBgColor: Colors.grey,
                  inactiveFgColor: Colors.white,
                  initialLabelIndex: isActive ? 1 : 0,
                  totalSwitches: 2,
                  labels: const ["False", "True"],
                  radiusStyle: true,
                  onToggle: (index) {
                    isActive = index == 1;
                  },
                ),
              ],
            ),
            const Spacer(),
            LoadingButtonView(
                onPressed: () {
                  if (operation.isAdd()) {
                    context.read<AddCommissionCubit>().addNewCommission(
                        _services.value!.id!,
                        _name.text,
                        _value.text,
                        isActive);
                  } else {
                    context.read<AddCommissionCubit>().updateCommission(
                        _commission!.commissionId!,
                        _services.value!.id!,
                        _name.text,
                        _value.text,
                        isActive);
                  }
                },
                text: "Submit",
                isLoading: state.status.isLoading)
          ],
        );
      }, listener: (context, state) {
        if (state.status.isSuccess) {
          showSnackBar(context, "Saved Successfully!!!");
          context.read<DashboardScreenBloc>().add(Empty());
        }
      }),
    );
  }
}
