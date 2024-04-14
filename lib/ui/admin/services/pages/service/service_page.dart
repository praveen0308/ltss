import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ltss/ui/admin/dashboard/bloc/dashboard_screen_bloc.dart';
import 'package:ltss/ui/admin/services/pages/service/service_page_cubit.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import '../../../../widgets/view_error_page.dart';
import 'service_data_grid.dart';

class ServicePage extends StatefulWidget {
  const ServicePage({super.key});

  @override
  State<ServicePage> createState() => _ServicePageState();
}

class _ServicePageState extends State<ServicePage> {
  @override
  void initState() {
    context.read<ServicePageCubit>().loadData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Data"),
              FilledButton(
                  onPressed: () {
                    context
                        .read<DashboardScreenBloc>()
                        .add(ToggleAddServicePage());
                  },
                  child: const Text("Add Service"))
            ],
          ),
          Expanded(
              child: BlocConsumer<ServicePageCubit, ServicePageState>(
                  builder: (context, state) {
            if (state is LoadingData || state is Deleting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is ReceivedData) {
              final data = state.data;
              final dataSource = ServiceDataSource(
                  data: data,
                  onUpdate: (int id) {
                    var service =
                        data.firstWhere((element) => element.id == id);
                    context
                        .read<DashboardScreenBloc>()
                        .add(ToggleAddServicePage(data: service));
                  },
                  onDelete: (int id) {
                    context.read<ServicePageCubit>().deleteService(id);
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
                              padding: const EdgeInsets.all(8.0),
                              alignment: Alignment.center,
                              child: const Text('ID')),
                        ),
                        GridColumn(
                            columnName: 'name',
                            columnWidthMode: ColumnWidthMode.fill,
                            label: Container(
                                padding: const EdgeInsets.all(8.0),
                                alignment: Alignment.centerLeft,
                                child: const Text('Name'))),
                        GridColumn(
                            columnName: 'addedOn',
                            columnWidthMode: ColumnWidthMode.fill,
                            label: Container(
                                padding: const EdgeInsets.all(8.0),
                                alignment: Alignment.centerLeft,
                                child: const Text('Added On'))),
                        GridColumn(
                            columnName: 'isActive',
                            columnWidthMode: ColumnWidthMode.fill,
                            label: Container(
                                padding: const EdgeInsets.all(8.0),
                                alignment: Alignment.centerLeft,
                                child: const Text(
                                  'Active',
                                  softWrap: false,
                                ))),
                        GridColumn(
                            columnName: 'update',
                            columnWidthMode: ColumnWidthMode.auto,
                            label: Container(
                                padding: const EdgeInsets.all(8.0),
                                alignment: Alignment.centerLeft,
                                child: const Text('Update'))),
                        GridColumn(
                            columnName: 'delete',
                            columnWidthMode: ColumnWidthMode.auto,
                            label: Container(
                                padding: const EdgeInsets.all(8.0),
                                alignment: Alignment.centerLeft,
                                child: const Text('Delete'))),
                      ]),
                ),
              );
            }
            if (state is LoadDataFailed) {
              return ErrorPageView(
                msg: state.msg,
              );
            }
            if (state is DeletionFailed) {
              return ErrorPageView(
                msg: state.msg,
              );
            }
            return Container();
          }, listener: (context, state) {
            if (state is DeletionSuccessful) {
              context.read<ServicePageCubit>().loadData();
            }
          }))
        ],
      ),
    );
  }
}
