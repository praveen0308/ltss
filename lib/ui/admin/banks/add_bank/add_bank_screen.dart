import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ltss/models/api/entity/bank_entity.dart';
import 'package:ltss/ui/admin/dashboard/bloc/dashboard_screen_bloc.dart';
import 'package:ltss/ui/widgets/widgets.dart';
import 'package:ltss/utils/ext_methods.dart';
import 'package:ltss/utils/operations.dart';
import 'package:toggle_switch/toggle_switch.dart';

import 'add_bank_cubit.dart';

class AddBankPage extends StatefulWidget {
  final BankEntity? bankEntity;

  const AddBankPage({super.key, this.bankEntity});

  @override
  State<AddBankPage> createState() => _AddBankPageState();
}

class _AddBankPageState extends State<AddBankPage> {
  final _bankCode = TextEditingController();
  final _name = TextEditingController();
  final _min = TextEditingController();
  final _max = TextEditingController();
  final _ifsc = TextEditingController();
  late BankEntity _bank;
  var isActive = true;
  var operation = Operations.add;

  @override
  void initState() {
    if (widget.bankEntity != null) {
      _bank = widget.bankEntity!;
      operation = Operations.update;
      _bankCode.text = _bank.code.toString();
      _name.text = _bank.name ?? "";
      _ifsc.text = _bank.ifsc ?? "";
      _min.text = _bank.min.toString();
      _max.text = _bank.max.toString();
      isActive = _bank.isActive!;
    }
    super.initState();
  }

  @override
  void dispose() {
    _name.dispose();
    _min.dispose();
    _max.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${operation.isAdd() ? "Add" : "Update"} Bank"),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
              onPressed: () {
                context.read<DashboardScreenBloc>().add(Empty());
              },
              icon: const Icon(Icons.close))
        ],
      ),
      body: BlocConsumer<AddBankCubit, AddBankState>(builder: (context, state) {
        return Column(
          children: [
            TextInputFieldView(
              label: "Bank Code",
              textEditingController: _bankCode,
              inputType: TextInputType.number,
            ),
            TextInputFieldView(label: "Name", textEditingController: _name),
            TextInputFieldView(
              label: "Min",
              textEditingController: _min,
              inputType: TextInputType.number,
            ),
            TextInputFieldView(
              label: "Max",
              textEditingController: _max,
              inputType: TextInputType.number,
            ),
            TextInputFieldView(label: "IFSC", textEditingController: _ifsc),
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
                    _bank = BankEntity();
                  }
                  _bank.code = int.parse(_bankCode.text);
                  _bank.name = _name.text;
                  _bank.min = double.parse(_min.text);
                  _bank.max = double.parse(_max.text);
                  _bank.ifsc = _ifsc.text;
                  _bank.isActive = isActive;
                  if (operation.isAdd()) {
                    context.read<AddBankCubit>().addNewBank(_bank);
                  } else {
                    context.read<AddBankCubit>().updateBank(_bank);
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
