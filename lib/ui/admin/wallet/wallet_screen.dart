import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ltss/base/base.dart';
import 'package:ltss/ui/admin/wallet/transactions_data_grid.dart';
import 'package:ltss/ui/admin/wallet/wallet_screen_cubit.dart';
import 'package:ltss/ui/widgets/widgets.dart';
import 'package:shimmer/shimmer.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:syncfusion_flutter_core/theme.dart';
class WalletScreen extends StatefulWidget {
  const WalletScreen({super.key});

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> with BasePageState {

  @override
  void initState() {
    // context.read<WalletScreenCubit>().loadWalletBalance();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return BlocListener<WalletScreenCubit, WalletScreenState>(
      listener: (context, state) {
        if (state is ReceivedWalletStats) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            context.read<WalletScreenCubit>().loadTransactions();
          });
        }
      },
      child: Column(
        children: [
          BlocBuilder<WalletScreenCubit, WalletScreenState>(
            builder: (context, state) {
              if(state is LoadingWalletStats){
                return Shimmer.fromColors(
                    baseColor: Theme.of(context).colorScheme.primaryContainer,
                    highlightColor: Theme.of(context).colorScheme.inversePrimary,
                    child: Row(
                      children: [
                        Container(
                          width:150,
                          height:80,
                          margin: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(8)
                          ),
                        ),
                        Container(
                          width:150,
                          height:80,
                          margin: const EdgeInsets.all(8),

                          decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(8)
                          ),
                        ),
                      ],
                    ));
              }
              if(state is LoadWalletStatsFailed){
                return Center(
                  child: Column(
                    children: [
                      const Icon(
                        Icons.error_rounded,
                        size: 80,
                      ),
                      Text(state.msg)
                    ],
                  ),
                );
              }
              if(state is ReceivedWalletStats){
                return SizedBox(
                  height: 150,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SizedBox(
                        width: 250,
                        child: Column(
                          children: [
                            Container(
                              margin: const EdgeInsets.all(2),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all()),
                              child:  ListTile(
                                visualDensity:
                                const VisualDensity(horizontal: 0, vertical: -4),
                                title: const Text("User Wallet"),
                                trailing: Text("₹${state.userWallet()?.balance ?? 0}"),
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.all(2),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all()),
                              child: ListTile(
                                visualDensity:
                                const VisualDensity(horizontal: 0, vertical: -4),
                                title: const Text("Service Wallet"),
                                trailing: Text("₹${state.serviceWallet()?.balance ?? 0}"),
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.all(2),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all()),
                              child: ListTile(
                                visualDensity:
                                const VisualDensity(horizontal: 0, vertical: -4),
                                title:const Text("Vendor Wallet"),
                                trailing: Text("₹${state.vendorWallet()?.balance ?? 0}"),
                              ),
                            ),
                          ],
                        ),
                      ),
                      DashboardItemView(
                          title: "Company Wallet",
                          subTitle: "₹${state.companyWallet()?.balance ?? 0}",
                          onClick: () {})
                    ],
                  ),
                );
              }
              return Container();
            },
            buildWhen: (prev, state) {
              return state is LoadingWalletStats ||
                  state is ReceivedWalletStats ||
                  state is LoadWalletStatsFailed;
            },
          ),

          const Text("Recent Transactions"),
          BlocBuilder<WalletScreenCubit, WalletScreenState>(
            builder: (context, state) {
              if(state is LoadingRecentTransactions){
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if(state is LoadRecentTransactionsFailed){
                return Center(
                  child: Column(
                    children: [
                      const Icon(
                        Icons.error_rounded,
                        size: 80,
                      ),
                      Text(state.msg)
                    ],
                  ),
                );
              }
              if(state is ReceivedRecentTransactions){
                final transactions = state.transactions;
                final transactionDataSource = TransactionsDataSource(transactions: transactions);
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SfDataGridTheme(
                    data: SfDataGridThemeData(
                        headerColor: Theme.of(context)
                            .colorScheme
                            .primaryContainer),
                    child: SfDataGrid(
                        footer: transactions.isEmpty?const Center(child: Text("No data available"),):null,
                        gridLinesVisibility: GridLinesVisibility.both,
                        headerGridLinesVisibility:
                        GridLinesVisibility.both,
                        source: transactionDataSource,
                        columns: <GridColumn>[
                          GridColumn(
                            columnName: 'id',
                            width: 50,
                            label: Container(
                                padding: EdgeInsets.all(8.0),
                                alignment: Alignment.center,
                                child: Text('ID')),
                          ),
                          GridColumn(
                              columnName: 'serviceId',
                              columnWidthMode: ColumnWidthMode.fill,
                              label: Container(
                                  padding: EdgeInsets.all(8.0),
                                  alignment: Alignment.centerLeft,
                                  child: Text('Service ID'))),
                          GridColumn(
                              columnName: 'customerId',
                              columnWidthMode: ColumnWidthMode.fill,
                              label: Container(
                                  padding: EdgeInsets.all(8.0),
                                  alignment: Alignment.centerLeft,
                                  child: Text('Customer ID'))),
                          GridColumn(
                              columnName: 'bankId',
                              columnWidthMode: ColumnWidthMode.fill,
                              label: Container(
                                  padding: EdgeInsets.all(8.0),
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    'Bank ID',
                                    softWrap: false,
                                  ))),

                          GridColumn(
                              columnName: 'amount',
                              columnWidthMode: ColumnWidthMode.fill,
                              label: Container(
                                  padding: EdgeInsets.all(8.0),
                                  alignment: Alignment.centerLeft,
                                  child: Text('Amount'))),
                          GridColumn(
                              columnName: 'status',
                              columnWidthMode: ColumnWidthMode.fill,
                              label: Container(
                                  padding: EdgeInsets.all(8.0),
                                  alignment: Alignment.centerLeft,
                                  child: Text('Status'))),
                          GridColumn(
                              columnName: 'addedBy',
                              columnWidthMode: ColumnWidthMode.fill,
                              label: Container(
                                  padding: EdgeInsets.all(8.0),
                                  alignment: Alignment.centerLeft,
                                  child: Text('Added By'))),

                        ]),
                  ),
                );
              }
              return Container();
            },
            buildWhen: (prev, state) {
              return state is LoadingRecentTransactions ||
                  state is ReceivedRecentTransactions ||
                  state is LoadRecentTransactionsFailed;
            },
          ),

        ],
      ),
    );
  }
}
