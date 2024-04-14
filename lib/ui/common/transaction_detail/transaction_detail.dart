import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ltss/base/base.dart';
import 'package:ltss/models/api/entity/dmt_transaction.dart';
import 'package:ltss/routes/route_imports.gr.dart';
import 'package:ltss/ui/common/transaction_action/transaction_action.dart';
import 'package:ltss/ui/common/transaction_detail/transaction_detail_cubit.dart';
import 'package:ltss/ui/widgets/view_highlighted_label.dart';
import 'package:ltss/ui/widgets/view_loading.dart';

import '../../admin/dashboard/bloc/dashboard_screen_bloc.dart';

@RoutePage()
class TransactionDetailScreen extends StatefulWidget
    implements AutoRouteWrapper {
  final DmtTransaction transaction;

  const TransactionDetailScreen({super.key, required this.transaction});

  static Widget create(DmtTransaction dmtTransaction){
    return BlocProvider(
      create: (context) => TransactionDetailCubit(
          RepositoryProvider.of<SessionManager>(context)),
      child: TransactionDetailScreen(transaction: dmtTransaction),
    );
  }

  @override
  State<TransactionDetailScreen> createState() =>
      _TransactionDetailScreenState();

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(
      create: (context) => TransactionDetailCubit(
          RepositoryProvider.of<SessionManager>(context)),
      child: this,
    );
  }
}

class _TransactionDetailScreenState extends State<TransactionDetailScreen> {
  late DmtTransaction transaction;

  @override
  void initState() {
    transaction = widget.transaction;
    context.read<TransactionDetailCubit>().init(transaction);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: const Text("Transaction Details"),
        automaticallyImplyLeading: Platform.isAndroid,
        actions: [
          if(Platform.isWindows)IconButton(
              onPressed: () {
                context.read<DashboardScreenBloc>().add(Empty());
              },
              icon: const Icon(Icons.close))
        ],
      ),
      body: BlocBuilder<TransactionDetailCubit, TransactionDetailState>(
        builder: (context, state) {
          if (state is Initializing) {
            return const LoadingView();
          }
          if (state is InitializationSuccessful) {
            return Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          DetailRow.vertical("Customer Details",
                              transaction.getCustomerWithLabel()),
                          DetailRow.vertical("Beneficiary Details",
                              transaction.getBeneficiaryWithLabel()),
                          DetailRow.vertical("Retailer Details",
                              transaction.getRetailerWithLabel()),
                          DetailRow.vertical("Vendor Details",
                              transaction.getVendorWithLabel()),
                          DetailRow("Amount", transaction.getFormattedAmount()),
                          DetailRow(
                              "Added On", transaction.getFormattedAddedOn()),
                          DetailRow(
                            "Status",
                            transaction.status ?? "",
                            isStatus: true,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                if (state.canAccept && state.canReject)
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: FilledButton(
                            onPressed: () {
                              AutoRouter.of(context).push(
                                  TransactionActionRoute(
                                      transaction: transaction,
                                      action: TransactionAction.reject));
                            },
                            style: FilledButton.styleFrom(
                                backgroundColor: Colors.red),
                            child: const Text(
                              "REJECT",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 16,
                        ),
                        Expanded(
                          child: FilledButton(
                            onPressed: () {
                              AutoRouter.of(context).push(
                                  TransactionActionRoute(
                                      transaction: transaction,
                                      action: TransactionAction.accept));
                            },
                            style: FilledButton.styleFrom(
                                backgroundColor: Colors.green),
                            child: const Text(
                              "ACCEPT",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                if (state.canMarkVerified)
                  FilledButton(
                    onPressed: () {
                      /*AutoRouter.of(context).push(TransactionActionRoute(
                          transaction: transaction,
                          action: TransactionAction.verify));*/
                      context.read<DashboardScreenBloc>().add(ToggleTransactionAction(transaction,TransactionAction.verify));
                    },
                    style:
                        FilledButton.styleFrom(backgroundColor: Colors.green),
                    child: const Text(
                      "VERIFY",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
              ],
            );
          }
          return Container();
        },
      ),
    ));
  }
}

class DetailRow extends StatelessWidget {
  final String title;
  final String value;
  final bool isStatus;
  final bool isVertical;

  const DetailRow(this.title, this.value,
      {super.key, this.isStatus = false, this.isVertical = false});

  factory DetailRow.vertical(String title, String value,
          {bool isStatus = false}) =>
      DetailRow(
        title,
        value,
        isStatus: isStatus,
        isVertical: true,
      );

  @override
  Widget build(BuildContext context) {
    if (isVertical) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            isStatus
                ? HighlightedLabel(
                    text: value,
                  )
                : Text(
                    value,
                    style: const TextStyle(fontSize: 17),
                  ),
          ],
        ),
      );
    } else {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            isStatus
                ? HighlightedLabel(
                    text: value,
                  )
                : Text(
                    value,
                    style: const TextStyle(fontSize: 17),
                  ),
          ],
        ),
      );
    }
  }
}
