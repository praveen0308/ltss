import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ltss/ui/admin/banks/bank_list_data_grid.dart';
import 'package:ltss/ui/admin/banks/manage_banks_cubit.dart';
import 'package:ltss/ui/admin/dashboard/bloc/dashboard_screen_bloc.dart';
import 'package:ltss/ui/widgets/view_error_page.dart';
import 'package:ltss/ui/widgets/view_loading.dart';
import 'package:ltss/ui/widgets/widgets.dart';

import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:syncfusion_flutter_core/theme.dart';

class ManageBanksScreen extends StatefulWidget {
  const ManageBanksScreen({super.key});

  @override
  State<ManageBanksScreen> createState() => _ManageBanksScreenState();
}

class _ManageBanksScreenState extends State<ManageBanksScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<ManageBanksCubit, ManageBanksState>(
  listener: (context, state) {
    if(state is DeletionSuccessful){
    context.read<ManageBanksCubit>().loadBanks();
  }
  },
  child: Column(
      children: [
        Row(
          children: [
            Expanded(
              child: SearchView(
                  onTextChanged: (text) {},
                  onSearch: (text) {
                    context.read<ManageBanksCubit>().searchBank(text);
                  }),
            ),
            FilledButton(
                onPressed: () {
                  context.read<DashboardScreenBloc>().add(ToggleAddBankPage());
                },
                child: const Text("Add Bank"))
          ],
        ),
        BlocBuilder<ManageBanksCubit, ManageBanksState>(
            builder: (context, state) {
          switch (state) {
            case ManageBanksInitial():
              return Container();
            case LoadingData():
              return const LoadingView();
            case ReceivedData():
              {
                var data = state.data;
                final banksDataSource = BankDataSource(
                    items: data,
                    onUpdate: (int id) {
                      var bank =
                          data.firstWhere((element) => element.bankId == id);
                      context
                          .read<DashboardScreenBloc>()
                          .add(ToggleAddBankPage(data: bank));
                    },
                    onDelete: (int id) {
                      context.read<ManageBanksCubit>().deleteBank(id);
                    });
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SfDataGridTheme(
                    data: SfDataGridThemeData(
                        headerColor:
                            Theme.of(context).colorScheme.primaryContainer),
                    child: SfDataGrid(
                        footer: data.isEmpty
                            ? const Center(
                                child: Text("No data available"),
                              )
                            : null,
                        gridLinesVisibility: GridLinesVisibility.both,
                        headerGridLinesVisibility: GridLinesVisibility.both,
                        source: banksDataSource,
                        columns: <GridColumn>[
                          GridColumn(
                            columnName: 'bank_id',
                            width: 50,
                            label: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8.0, vertical: 2),
                                alignment: Alignment.center,
                                child: const Text('ID')),
                          ), GridColumn(
                            columnName: 'code',
                            width: 50,
                            label: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8.0, vertical: 2),
                                alignment: Alignment.center,
                                child: const Text('Code')),
                          ),
                          GridColumn(
                              columnName: 'name',
                              columnWidthMode: ColumnWidthMode.fill,
                              label: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0, vertical: 2),
                                  alignment: Alignment.centerLeft,
                                  child: Text('Name'))),GridColumn(
                              columnName: 'ifsc',
                              columnWidthMode: ColumnWidthMode.fill,
                              label: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0, vertical: 2),
                                  alignment: Alignment.centerLeft,
                                  child: Text('IFSC'))),
                          GridColumn(
                              columnName: 'min',
                              columnWidthMode: ColumnWidthMode.fill,
                              label: Container(
                                  padding: EdgeInsets.all(8.0),
                                  alignment: Alignment.centerLeft,
                                  child: Text('Min. Amount'))),
                          GridColumn(
                              columnName: 'max',
                              columnWidthMode: ColumnWidthMode.fill,
                              label: Container(
                                  padding: EdgeInsets.all(8.0),
                                  alignment: Alignment.centerLeft,
                                  child: Text('Max. Amount'))),
                          GridColumn(
                              columnName: 'is_active',
                              columnWidthMode: ColumnWidthMode.fill,
                              label: Container(
                                  padding: EdgeInsets.all(8.0),
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    'Is Active',
                                    softWrap: false,
                                  ))),
                          GridColumn(
                              columnName: 'update',
                              columnWidthMode: ColumnWidthMode.auto,
                              label: Container(
                                  padding: EdgeInsets.all(8.0),
                                  alignment: Alignment.centerLeft,
                                  child: Text('Update'))),
                          GridColumn(
                              columnName: 'delete',
                              columnWidthMode: ColumnWidthMode.auto,
                              label: Container(
                                  padding: EdgeInsets.all(8.0),
                                  alignment: Alignment.centerLeft,
                                  child: Text('Delete'))),
                        ]),
                  ),
                );
              }

            case LoadDataFailed():
              return ErrorPageView(
                msg: state.msg,
              );
            case Deleting():
              return const LoadingView();
            case DeletionSuccessful():
              return Container();
            case DeletionFailed():
              return ErrorPageView(
                msg: state.msg,
              );
          }
        })
      ],
    ),
);
  }
}
