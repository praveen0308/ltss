import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:ltss/base/base.dart';
import 'package:ltss/models/api/entity/bank_entity.dart';
import 'package:ltss/models/api/entity/user_entity.dart';
import 'package:ltss/ui/admin/banks/select_vendor/select_vendor.dart';
import 'package:ltss/ui/admin/banks/select_vendor/select_vendor_cubit.dart';
import 'package:ltss/ui/admin/dashboard/bloc/dashboard_screen_bloc.dart';
import 'package:ltss/ui/widgets/widgets.dart';
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
  UserEntity? _selectedVendor;
  BankEntity? _assignedBank;

  // var vendorList = List<DropdownMenuItem<UserEntity>>.empty(growable: true);

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
      // context.read<AddBankCubit>().loadVendors(_bank.bankId!);
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

  void _dialogStack() async {
    stackDialog({
      required Alignment alignment,
      required String tag,
      double width = double.infinity,
      double height = double.infinity,
    }) async {
      var result = await SmartDialog.show(
        tag: tag,
        alignment: alignment,
        builder: (_) {
          return BlocProvider(
            create: (context) => SelectVendorCubit(
                RepositoryProvider.of<UserRepository>(context),
                RepositoryProvider.of<BankRepository>(context)),
            child: const SelectVendorScreen(),
          );
        },
      );

      if (result != null) {
        _selectedVendor = result.vendor;
        _assignedBank = result.bank;
        setState(() {});
      }
    }

    await stackDialog(
        tag: 'selectVendor',
        width: MediaQuery.of(context).size.width * 0.3,
        alignment: Alignment.centerRight);
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
        /*if (state.status.isInitialising || state.status.isInitial) {
          return const LoadingView();
        }
        if (state.status.isInitialisationFailed) {
          return ErrorPageView(
            msg: state.msg,
          );
        }*/
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              OutlinedButton(
                  onPressed: () {
                    _dialogStack();
                  },
                  child: const Text("Select Vendor")),
              const SizedBox(
                height: 16,
              ),
              if (_selectedVendor != null)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Text(
                      "Selected Vendor",
                      style: TextStyle(fontSize: 16),
                    ),
                    ListTile(
                      leading: CircleAvatar(
                          child:
                              Text(_selectedVendor?.getName().take(1) ?? "_")),
                      title: Text(
                        _selectedVendor?.getName() ?? "Nil",
                      ),
                      subtitle: _assignedBank != null
                          ? Text(
                              _assignedBank!.name ?? "Nil",
                            )
                          : null,
                      trailing: IconButton(
                          onPressed: () {
                            _selectedVendor = null;
                            _assignedBank = null;
                            setState(() {});
                          },
                          icon: const Icon(Icons.close)),
                    ),
                    /*if (_assignedBank != null)
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: const BoxDecoration(
                            color: AppColors.primaryLightest),
                        child: const Text(
                            "Note: If you have selected a vendor that is already assigned to other bank then it will be reset."),
                      ),*/
                  ],
                ),
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
              /* Container(
                margin: const EdgeInsets.symmetric(vertical: 8),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all()),
                child: SearchChoices.single(
                  displayClearIcon: false,
                  underline: "",
                  padding: const EdgeInsets.all(5),
                  items: vendorList,
                  value: _selectedVendor,
                  hint: "Select one",
                  searchHint: "Select one",
                  onChanged: (value) {
                    setState(() {
                      _selectedVendor = value;
                    });
                  },
                  isExpanded: true,
                ),
              ),*/

              const SizedBox(
                height: 24,
              ),
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
                      context.read<AddBankCubit>().addNewBank(_bank,vendorId: _selectedVendor?.id);
                    } else {
                      context.read<AddBankCubit>().updateBank(_bank,vendorId: _selectedVendor?.id);
                    }
                  },
                  text: "Submit",
                  isLoading: state.status.isLoading)
            ],
          ),
        );
      }, listener: (context, state) {
        if (state.status.isSuccess) {
          showSnackBar(context, "Saved Successfully!!!");
          context.read<DashboardScreenBloc>().add(Empty());
        }
        if (state.status.isInitialisationSuccessful) {
          /*if (state.assignedVendor != null) {
            _selectedVendor = state.assignedVendor!;
          }
          vendorList.clear();
          if (state.vendors != null) {
            vendorList.addAll(state.vendors!.map((e) => DropdownMenuItem(
                  value: e,
                  child: Text(e.getName()),
                )));
          }*/
        }
      }),
    );
  }
}
