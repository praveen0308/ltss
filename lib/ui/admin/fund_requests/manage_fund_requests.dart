import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ltss/ui/admin/fund_requests/fund_requests_data_grid.dart';
import 'package:ltss/ui/admin/fund_requests/fund_requests_history_data_grid.dart';
import 'package:ltss/ui/widgets/view_error_page.dart';
import 'package:ltss/ui/widgets/view_loading.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:syncfusion_flutter_core/theme.dart';

import 'manage_fund_requests_cubit.dart';

class ManageFundRequestsScreen extends StatefulWidget {
  const ManageFundRequestsScreen({super.key});

  @override
  State<ManageFundRequestsScreen> createState() => _ManageFundRequestsScreenState();
}

class _ManageFundRequestsScreenState extends State<ManageFundRequestsScreen> {

  @override
  void initState() {
    context.read<ManageFundRequestsCubit>().fetchReceivedRequests();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return BlocListener<ManageFundRequestsCubit, ManageFundRequestsState>(
      listener: (context, state) {
        if(state is UpdateSuccessful){
          context.read<ManageFundRequestsCubit>().fetchReceivedRequests();
        }
      },
      child: BlocBuilder<ManageFundRequestsCubit, ManageFundRequestsState>(
          builder: (context, state) {
            switch (state) {
              case ManageFundRequestsInitial():
                return Container();
              case LoadingData():
                return const LoadingView();
              case ReceivedData():
                {
                  var newRequests = state.newRequests;
                  var history = state.history;
                  final newRequestsDataSource = FundRequestsDataSource(
                      items: newRequests,
                      onRejected: (int id) {

                        context.read<ManageFundRequestsCubit>().updateFundRequest(id, "REJECTED");
                      },
                      onAccepted: (int id) {
                        context.read<ManageFundRequestsCubit>().updateFundRequest(id, "APPROVED");
                      });
                  final historyDataSource = FundRequestsHistoryDataSource(
                      items: history);
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("New Requests",style: Theme.of(context).textTheme.titleMedium,),
                          const SizedBox(height: 8,),
                          SfDataGridTheme(
                            data: SfDataGridThemeData(
                                headerColor:
                                Theme.of(context).colorScheme.primaryContainer),
                            child: SfDataGrid(
                                footer: newRequests.isEmpty
                                    ? const Center(
                                  child: Text("No new requests!!!"),
                                )
                                    : null,
                                gridLinesVisibility: GridLinesVisibility.both,
                                headerGridLinesVisibility: GridLinesVisibility.both,
                                source: newRequestsDataSource,
                                columns: <GridColumn>[
                                  GridColumn(
                                    columnName: 'id',
                                    width: 50,
                                    label: Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8.0, vertical: 2),
                                        alignment: Alignment.center,
                                        child: const Text('ID')),
                                  ),GridColumn(
                                    columnName: 'role',
                                    width: 50,
                                    label: Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8.0, vertical: 2),
                                        alignment: Alignment.center,
                                        child: const Text('Role')),
                                  ),
                                  GridColumn(
                                      columnName: 'name',
                                      columnWidthMode: ColumnWidthMode.fill,
                                      label: Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8.0, vertical: 2),
                                          alignment: Alignment.centerLeft,
                                          child: Text('Sender'))),
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
                                      columnName: 'reject',
                                      columnWidthMode: ColumnWidthMode.auto,
                                      label: Container(
                                          padding: EdgeInsets.all(8.0),
                                          alignment: Alignment.centerLeft,
                                          child: Text('Reject'))),
                                  GridColumn(
                                      columnName: 'accept',
                                      columnWidthMode: ColumnWidthMode.auto,
                                      label: Container(
                                          padding: EdgeInsets.all(8.0),
                                          alignment: Alignment.centerLeft,
                                          child: Text('Approve'))),
                                ]),
                          ),
                          Text("History",style: Theme.of(context).textTheme.titleMedium,),
                          const SizedBox(height: 8,),
                          SfDataGridTheme(
                            data: SfDataGridThemeData(
                                headerColor:
                                Theme.of(context).colorScheme.primaryContainer),
                            child: SfDataGrid(
                                footer: history.isEmpty
                                    ? const Center(
                                  child: Text("No data available!!!"),
                                )
                                    : null,
                                gridLinesVisibility: GridLinesVisibility.both,
                                headerGridLinesVisibility: GridLinesVisibility.both,
                                source: historyDataSource,
                                columns: <GridColumn>[
                                  GridColumn(
                                    columnName: 'id',
                                    width: 50,
                                    label: Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8.0, vertical: 2),
                                        alignment: Alignment.center,
                                        child: const Text('ID')),
                                  ),GridColumn(
                                    columnName: 'role',
                                    width: 50,
                                    label: Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8.0, vertical: 2),
                                        alignment: Alignment.center,
                                        child: const Text('Role')),
                                  ),
                                  GridColumn(
                                      columnName: 'name',
                                      columnWidthMode: ColumnWidthMode.fill,
                                      label: Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8.0, vertical: 2),
                                          alignment: Alignment.centerLeft,
                                          child: Text('Sender'))),
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

                                ]),
                          ),
                        ],
                      ),
                    ),
                  );
                }

              case LoadDataFailed():
                return ErrorPageView(
                  msg: state.msg,
                );
              case Updating():
                return const LoadingView();
              case UpdateSuccessful():
                return Container();
              case UpdateFailed():
                return ErrorPageView(
                  msg: state.msg,
                );
              case EmptyData():
                return const ErrorPageView(
                  msg: "No new requests!!!",
                );
            }
          }),
    );
  }
}
