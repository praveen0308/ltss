import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ltss/ui/admin/dashboard/bloc/dashboard_screen_bloc.dart';
import 'package:ltss/ui/admin/manage_dmt/transactions/dmt_transactions_cubit.dart';
import 'package:ltss/ui/admin/manage_dmt/transactions/dmt_transactions_data_grid.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class DMTTransactionsScreen extends StatefulWidget {
  const DMTTransactionsScreen({super.key});

  @override
  State<DMTTransactionsScreen> createState() => _DMTTransactionsScreenState();
}

class _DMTTransactionsScreenState extends State<DMTTransactionsScreen> {
  @override
  void initState() {
    context.read<DmtTransactionsCubit>().loadTransactions();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DmtTransactionsCubit, DmtTransactionsState>(
        builder: (context, state) {
      if (state is LoadTransactionsSuccessful) {
        final transactions = state.items;
        final userDataSource = DmtTransactionsDataSource(
            onViewClick: (int id) {
              /*var user =
                  vendors.firstWhere((element) => element.vendorId == id);
                  context
                      .read<DashboardScreenBloc>()
                      .add(ToggleUserDetailPage(userId: id));*/
              var transaction = transactions
                  .firstWhere((element) => element.transactionId == id);
              context
                  .read<DashboardScreenBloc>()
                  .add(ToggleTransactionDetails(transaction));
            },
            onEditClick: (int id) {
              var transaction = transactions
                  .firstWhere((element) => element.transactionId == id);
              context
                  .read<DashboardScreenBloc>()
                  .add(ToggleEditTransaction(transaction));
            },
            onDeleteClick: (int id) {},
            items: transactions);
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: SfDataGridTheme(
            data: SfDataGridThemeData(
                headerColor: Theme.of(context).colorScheme.primaryContainer),
            child: SfDataGrid(
                isScrollbarAlwaysShown: true,
                rowHeight: 50,
                headerRowHeight: 30,
                footer: transactions.isEmpty
                    ? const Center(
                        child: Text("No data available"),
                      )
                    : null,
                gridLinesVisibility: GridLinesVisibility.horizontal,
                rowsPerPage: 10,
                headerGridLinesVisibility: GridLinesVisibility.horizontal,
                source: userDataSource,
                allowSorting: true,
                allowFiltering: true,
                columns: <GridColumn>[
                  GridColumn(
                    allowFiltering: false,
                    columnName: 'id',
                    width: 50,
                    label: Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: const Text('ID')),
                  ),
                  GridColumn(
                      allowFiltering: false,
                      columnName: 'customer',
                      columnWidthMode: ColumnWidthMode.auto,
                      label: Container(
                          alignment: Alignment.centerLeft,
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: const Text('Customer'))),
                  GridColumn(
                      allowFiltering: false,
                      columnName: 'beneficiary',
                      columnWidthMode: ColumnWidthMode.auto,
                      label: Container(
                          alignment: Alignment.centerLeft,
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: const Text('Beneficiary'))),
                  GridColumn(
                      allowFiltering: false,
                      columnName: 'retailer',
                      columnWidthMode: ColumnWidthMode.auto,
                      label: Container(
                          alignment: Alignment.centerLeft,
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: const Text('Retailer'))),
                  GridColumn(
                      allowFiltering: false,
                      columnName: 'vendor',
                      columnWidthMode: ColumnWidthMode.auto,
                      label: Container(
                          alignment: Alignment.centerLeft,
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: const Text('Vendor'))),
                  GridColumn(
                      allowSorting: false,
                      columnName: 'bank_id',
                      columnWidthMode: ColumnWidthMode.auto,
                      label: Container(
                          alignment: Alignment.centerLeft,
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: const Text('Bank ID'))),
                  GridColumn(
                      allowSorting: false,
                      columnName: 'bank_name',
                      columnWidthMode: ColumnWidthMode.auto,
                      label: Container(
                          alignment: Alignment.centerLeft,
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: const Text('Bank Name'))),
                  GridColumn(
                      allowSorting: false,
                      columnName: 'trans_mode',
                      columnWidthMode: ColumnWidthMode.auto,
                      label: Container(
                          alignment: Alignment.centerLeft,
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: const Text('Trans Mode'))),
                  GridColumn(
                      columnName: 'amount',
                      columnWidthMode: ColumnWidthMode.auto,
                      allowFiltering: false,
                      label: Container(
                          alignment: Alignment.centerLeft,
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: const Text('Amount'))),
                  GridColumn(
                      columnName: 'commission',
                      allowFiltering: false,
                      columnWidthMode: ColumnWidthMode.auto,
                      label: Container(
                          alignment: Alignment.centerLeft,
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: const Text('Commission'))),
                  GridColumn(
                      columnName: 'charge',
                      allowFiltering: false,
                      columnWidthMode: ColumnWidthMode.auto,
                      label: Container(
                          alignment: Alignment.centerLeft,
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: const Text('Charge'))),
                  GridColumn(
                      columnName: 'status',
                      columnWidthMode: ColumnWidthMode.auto,
                      allowSorting: false,
                      label: Container(
                          alignment: Alignment.centerLeft,
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: const Text('Status'))),
                  GridColumn(
                      columnName: 'comment',
                      columnWidthMode: ColumnWidthMode.auto,
                      label: Container(
                          alignment: Alignment.centerLeft,
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: const Text('Comment'))),
                  GridColumn(
                      columnName: 'added_on',
                      columnWidthMode: ColumnWidthMode.auto,
                      label: Container(
                          alignment: Alignment.centerLeft,
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: const Text('Added On'))),
                  GridColumn(
                      columnName: 'modified_on',
                      columnWidthMode: ColumnWidthMode.auto,
                      label: Container(
                          alignment: Alignment.centerLeft,
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: const Text('Modified On'))),
                  GridColumn(
                      columnName: 'added_by',
                      columnWidthMode: ColumnWidthMode.auto,
                      label: Container(
                          alignment: Alignment.centerLeft,
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: const Text('Added By'))),
                  GridColumn(
                      columnName: 'modified_by',
                      columnWidthMode: ColumnWidthMode.auto,
                      label: Container(
                          alignment: Alignment.centerLeft,
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: const Text('Modified By'))),
                  GridColumn(
                      allowFiltering: false,
                      columnName: 'actions',
                      width: 120,
                      allowSorting: false,
                      label: Container(
                          alignment: Alignment.center,
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: const Text('Actions'))),
                ]),
          ),
        );
      }
      if (state is LoadingTransactions) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }
      if (state is LoadTransactionsFailed) {
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
      return Container();
    });
  }
}
