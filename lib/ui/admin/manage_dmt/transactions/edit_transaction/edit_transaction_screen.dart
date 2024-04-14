import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:ltss/base/base.dart';
import 'package:ltss/models/api/entity/bank_entity.dart';
import 'package:ltss/models/api/entity/dmt_transaction.dart';
import 'package:ltss/models/api/entity/user_entity.dart';
import 'package:ltss/ui/admin/banks/select_vendor/select_vendor.dart';
import 'package:ltss/ui/admin/dashboard/bloc/dashboard_screen_bloc.dart';
import 'package:ltss/ui/admin/manage_dmt/transactions/edit_transaction/edit_transaction_cubit.dart';
import 'package:ltss/ui/common/transaction_detail/transaction_detail.dart';
import 'package:ltss/ui/widgets/adaptive_app_bar.dart';
import 'package:ltss/ui/widgets/view_loading_button.dart';

/// Objective: Reassignment of vendor and status set back to "REQUESTED"
/// Step 1: Load Transaction detail
/// Step 2: Load DMT vendors
/// Step 3: Update vendor id

class EditTransactionScreen extends StatefulWidget {
  final DmtTransaction transaction;

  const EditTransactionScreen({super.key, required this.transaction});

  static Widget create(DmtTransaction transaction) {
    return BlocProvider(
      create: (context) =>
          EditTransactionCubit(RepositoryProvider.of<DMTRepository>(context)),
      child: EditTransactionScreen(
        transaction: transaction,
      ),
    );
  }

  @override
  State<EditTransactionScreen> createState() => _EditTransactionScreenState();
}

class _EditTransactionScreenState extends State<EditTransactionScreen> {
  UserEntity? _selectedVendor;
  BankEntity? _assignedBank;

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
          return SelectVendorScreen.create();
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
    return SafeArea(
      child: Scaffold(
        appBar: const AdaptiveAppBar(
          title: "Edit Transaction",
        ),
        body: BlocConsumer<EditTransactionCubit, EditTransactionState>(
          listener: (context, state) {
            if(state.status.isSuccess){
              showToast("Transaction updated successfully!!", ToastType.success);
              context.read<DashboardScreenBloc>().add(Empty());
            }
            if(state.status.isError){
              showToast(state.msg??"Something went wrong!!!", ToastType.error);
            }

          },
          builder: (context, state) {
            return Stack(
              children: [
                SingleChildScrollView(
                  child: Column(
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
                                  child: Text(
                                      _selectedVendor?.getName().take(1) ??
                                          "_")),
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
                          ],
                        ),
                      DetailRow.vertical("Customer Details",
                          widget.transaction.getCustomerWithLabel()),
                      DetailRow.vertical(
                          "Beneficiary Details",
                          widget.transaction
                              .getBeneficiaryWithLabel()),
                      DetailRow.vertical("Retailer Details",
                          widget.transaction.getRetailerWithLabel()),
                      DetailRow.vertical("Vendor Details",
                          widget.transaction.getVendorWithLabel()),
                      DetailRow("Amount",
                          widget.transaction.getFormattedAmount()),
                      DetailRow("Added On",
                          widget.transaction.getFormattedAddedOn()),
                      DetailRow(
                        "Status",
                        widget.transaction.status ?? "",
                        isStatus: true,
                      ),
                      const SizedBox(height: 200),
                    ],
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: LoadingButtonView(
                      onPressed: () {
                        if (_selectedVendor != null) {
                          context.read<EditTransactionCubit>().updateTransaction(
                              widget.transaction.transactionId!,
                              _selectedVendor!.id!);
                        } else {
                          showToast(
                              "Please select valid vendor!!", ToastType.error);
                        }
                      },
                      text: "Update",
                      isLoading: state.status.isLoading),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
