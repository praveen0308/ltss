import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ltss/models/api/entity/service_entity.dart';
import 'package:ltss/ui/admin/dashboard/bloc/dashboard_screen_bloc.dart';
import 'package:ltss/ui/widgets/widgets.dart';
import 'package:ltss/utils/ext_methods.dart';
import 'package:ltss/utils/operations.dart';
import 'package:toggle_switch/toggle_switch.dart';

import 'add_service_cubit.dart';

class AddServicePage extends StatefulWidget {
  final ServiceEntity? service;

  const AddServicePage({super.key, this.service});

  @override
  State<AddServicePage> createState() => _AddServicePageState();
}

class _AddServicePageState extends State<AddServicePage> {
  final _name = TextEditingController();
  var isActive = true;
  var operation = Operations.add;
  late ServiceEntity service;

  @override
  void initState() {
    if (widget.service != null) {
      service = widget.service!;
      operation = Operations.update;
      _name.text = service.name!;
      isActive = service.isActive!;
    }
    super.initState();
  }

  @override
  void dispose() {
    _name.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(operation.isAdd() ? "Add Service" : "Update Service"),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
              onPressed: () {
                context.read<DashboardScreenBloc>().add(Empty());
              },
              icon: const Icon(Icons.close)),
        ],
      ),
      body: BlocConsumer<AddServiceCubit, AddServiceState>(
          builder: (context, state) {
        return Column(
          children: [
            TextInputFieldView(label: "Name", textEditingController: _name),
            const SizedBox(
              height: 16,
            ),
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
                    context.read<AddServiceCubit>().addNewService(
                          _name.text,
                        isActive
                        );
                  } else {
                    context
                        .read<AddServiceCubit>()
                        .updateService(service.id!, _name.text, isActive);
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
