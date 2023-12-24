import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:ltss/base/base.dart';
import 'package:ltss/models/api/entity/bank_entity.dart';
import 'package:ltss/models/api/entity/bank_vendor.dart';
import 'package:ltss/res/colors.dart';
import 'package:ltss/ui/admin/banks/select_vendor/select_vendor_cubit.dart';
import 'package:ltss/ui/widgets/view_error_page.dart';
import 'package:ltss/ui/widgets/view_loading.dart';
import 'package:ltss/ui/widgets/widgets.dart';

@RoutePage()
class SelectVendorScreen extends StatefulWidget {
  final BankEntity? bank;
  final int? assignedVendor;

  const SelectVendorScreen({super.key, this.bank, this.assignedVendor});

  @override
  State<SelectVendorScreen> createState() => _SelectVendorScreenState();
}

class _SelectVendorScreenState extends State<SelectVendorScreen>
    with BasePageState<SelectVendorScreen> {
  @override
  void initState() {
    context.read<SelectVendorCubit>().fetchBankVendors(widget.assignedVendor);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Select Vendor"),
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
                onPressed: () {
                  SmartDialog.dismiss(tag: "selectVendor");
                },
                icon: const Icon(Icons.close))
          ],
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SearchView(
                onTextChanged: (q) {
                  context.read<SelectVendorCubit>().filterResult(q);
                },
                onSearch: (q) {
                  context.read<SelectVendorCubit>().filterResult(q);
                }),
            Expanded(
              child: BlocConsumer<SelectVendorCubit, SelectVendorState>(
                  builder: (context, state) {
                switch (state) {
                  case SelectVendorInitial():
                    return Container();
                  case Initializing():
                    return const LoadingView();
                  case ReceivedVendors():
                    {
                      if (state.vendors.isEmpty) {
                        return const ErrorPageView(msg: "No data",);
                      } else {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Container(
                              color: AppColors.primaryLightest,
                              alignment: Alignment.centerLeft,
                              child: TextButton.icon(
                                  onPressed: () {
                                    if (widget.bank != null) {
                                      context
                                          .read<SelectVendorCubit>()
                                          .assignToNone(widget.bank!.bankId!);
                                    } else {
                                      SmartDialog.dismiss(tag: "selectVendor");
                                    }
                                  },
                                  icon: const Icon(Icons.close),
                                  label: const Text("Assign to None")),
                            ),
                            Expanded(
                              child: ListView.separated(
                                  itemBuilder: (context, index) {
                                    var bankVendor = state.vendors[index];
                                    return RadioListTile<BankVendor>(
                                        title: Text(
                                            bankVendor.vendor?.getName() ??
                                                "Nil"),
                                        subtitle: Text(
                                            "Bank: ${bankVendor.bank?.name ?? "Not Assigned"}"),
                                        value: bankVendor,
                                        groupValue: context
                                            .read<SelectVendorCubit>()
                                            .selectedVendor,
                                        onChanged: (v) {
                                          context
                                              .read<SelectVendorCubit>()
                                              .setSelectedVendor(v!);
                                          setState(() {});
                                        });
                                  },
                                  separatorBuilder: (context, index) {
                                    return const Divider();
                                  },
                                  itemCount: state.vendors.length),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: FilledButton(
                                onPressed: () {
                                  if (widget.bank != null) {
                                    context
                                        .read<SelectVendorCubit>()
                                        .updateBankVendor(widget.bank!.bankId!);
                                  } else {
                                    // AutoRouter.of(context).pop();
                                    SmartDialog.dismiss(
                                        tag: "selectVendor",
                                        result: context
                                            .read<SelectVendorCubit>()
                                            .selectedVendor);
                                  }
                                },

                                child: Text(
                                  "Proceed".toUpperCase(),
                                  style: const TextStyle(
                                      fontSize: 16, letterSpacing: 1.5),
                                ),
                              ),
                            )
                          ],
                        );
                      }
                    }

                  case InitializationFailed():
                    return ErrorPageView(
                      msg: state.msg,
                    );
                  default:
                    return Container();
                }
              }, listener: (context, state) {
                if (state is Updating) {
                  SmartDialog.showLoading();
                } else {
                  // SmartDialog.dismiss();
                }

                if (state is UpdateSuccessful) {
                  showToast("Updated successfully!!!", ToastType.success);
                }
                if (state is UpdateFailed) {
                  showToast(state.msg, ToastType.error);
                }
              }),
            ),
          ],
        ),
      ),
    );
  }
}
