import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ltss/ui/admin/services/pages/charges/charges_data_grid.dart';
import 'package:ltss/ui/admin/services/pages/charges/charges_page_cubit.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:syncfusion_flutter_core/theme.dart';

import '../../../dashboard/bloc/dashboard_screen_bloc.dart';

class ChargesPage extends StatefulWidget {
  const ChargesPage({super.key});

  @override
  State<ChargesPage> createState() => _ChargesPageState();
}

class _ChargesPageState extends State<ChargesPage> {
  @override
  void initState() {
    // context.read<ChargesPageCubit>().loadData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text("Data"),
            FilledButton(
                onPressed: () {
                  context
                      .read<DashboardScreenBloc>()
                      .add(ToggleAddChargePage());
                },
                child: Text("Add Charge"))
          ],
        ),
        Expanded(
            child: BlocConsumer<ChargesPageCubit, ChargesPageState>(
                builder: (context, state) {
          if (state is LoadingData || state is Deleting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is ReceivedData) {
            final data = state.data;
            final dataSource = ChargesDataSource(
                data: data,
                onUpdate: (int id) {
                  var item =
                      data.firstWhere((element) => element.chargeId == id);
                  context
                      .read<DashboardScreenBloc>()
                      .add(ToggleAddChargePage(data: item));
                },
                onDelete: (int id) {
                  context.read<ChargesPageCubit>().deleteCharge(id);
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
                    source: dataSource,
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
                        width: 50,
                        label: Container(
                            padding: EdgeInsets.all(8.0),
                            alignment: Alignment.center,
                            child: Text('Service ID')),
                      ),
                      GridColumn(
                          columnName: 'name',
                          columnWidthMode: ColumnWidthMode.fill,
                          label: Container(
                              padding: EdgeInsets.all(8.0),
                              alignment: Alignment.centerLeft,
                              child: Text('Name'))),
                      GridColumn(
                          columnName: 'value',
                          columnWidthMode: ColumnWidthMode.fill,
                          label: Container(
                              padding: EdgeInsets.all(8.0),
                              alignment: Alignment.centerLeft,
                              child: Text('Value'))),
                      GridColumn(
                          columnName: 'addedOn',
                          columnWidthMode: ColumnWidthMode.fill,
                          label: Container(
                              padding: EdgeInsets.all(8.0),
                              alignment: Alignment.centerLeft,
                              child: Text('Added On'))),
                      GridColumn(
                          columnName: 'isActive',
                          columnWidthMode: ColumnWidthMode.fill,
                          label: Container(
                              padding: EdgeInsets.all(8.0),
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Active',
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
          if (state is LoadDataFailed) {
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
        }, listener: (context, state) {
          if (state is DeletionSuccessful) {
            context.read<ChargesPageCubit>().loadData();
          }
        }))
      ],
    );
  }
}
