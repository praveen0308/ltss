import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ltss/models/api/entity/charge_entity.dart';
import 'package:ltss/models/api/entity/service_entity.dart';
import 'package:ltss/ui/admin/dashboard/bloc/dashboard_screen_bloc.dart';
import 'package:ltss/ui/widgets/view_error_page.dart';
import 'package:ltss/ui/widgets/widgets.dart';
import 'package:ltss/utils/ext_methods.dart';
import 'package:ltss/utils/operations.dart';
import 'package:toggle_switch/toggle_switch.dart';

import 'add_charge_cubit.dart';

class AddChargePage extends StatefulWidget {
  final ChargeEntity? chargeEntity;

  const AddChargePage({super.key, this.chargeEntity});

  @override
  State<AddChargePage> createState() => _AddChargePageState();
}

class _AddChargePageState extends State<AddChargePage> {
  final DropdownFieldViewController<ServiceEntity> _services =
      DropdownFieldViewController<ServiceEntity>();
  final _name = TextEditingController();
  final _value = TextEditingController();
  var isActive = true;

  ChargeEntity? _charge;
  var operation = Operations.add;

  @override
  void initState() {
    if (widget.chargeEntity != null) {
      _charge = widget.chargeEntity!;
      operation = Operations.update;

      _name.text = _charge?.name ?? "";
      _value.text = _charge?.value ?? "";
      isActive = _charge!.isActive!;
    }
    context.read<AddChargeCubit>().loadServices();
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
        title: Text("${operation.isAdd() ? "Add" : "Update"} Charge"),
        actions: [
          IconButton(
              onPressed: () {
                context.read<DashboardScreenBloc>().add(Empty());
              },
              icon: const Icon(Icons.close))
        ],
        automaticallyImplyLeading: false,
      ),
      body: BlocConsumer<AddChargeCubit, AddChargeState>(
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
          if (_charge != null) {
            var service = state.services
                ?.firstWhere((element) => element.id == _charge!.serviceId);
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
            const SizedBox(
              height: 16,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Is Active"),
                ToggleSwitch(
                  minWidth: 70.0,
                  cornerRadius: 5.0,
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
                    context.read<AddChargeCubit>().addNewCharge(
                        _services.value!.id!,
                        _name.text,
                        _value.text,
                        isActive);
                  } else {
                    context.read<AddChargeCubit>().updateCharge(
                        _charge!.chargeId!,
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
