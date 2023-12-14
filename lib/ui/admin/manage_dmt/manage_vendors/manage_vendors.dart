import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ltss/ui/admin/dashboard/bloc/dashboard_screen_bloc.dart';
import 'package:ltss/ui/admin/manage_dmt/manage_vendors/manage_vendors_cubit.dart';
import 'package:ltss/ui/admin/manage_dmt/manage_vendors/vendors_data_grid.dart';
import 'package:ltss/ui/widgets/search_view.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:syncfusion_flutter_core/theme.dart';

class ManageDMTVendorsScreen extends StatefulWidget {
  const ManageDMTVendorsScreen({super.key});

  @override
  State<ManageDMTVendorsScreen> createState() => _ManageDMTVendorsScreenState();
}

class _ManageDMTVendorsScreenState extends State<ManageDMTVendorsScreen> {

  @override
  void initState() {
    context.read<ManageVendorsCubit>().loadVendors();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            FilledButton(onPressed: () {
              context.read<DashboardScreenBloc>().add(ToggleAddDmtVendorPage());
            }, child: const Text("Add Vendor")),
            SizedBox(width: 300,child: SearchView(onTextChanged: (txt) {}, onSearch: (txt) {})),
          ],
        ),

        BlocBuilder<ManageVendorsCubit, ManageVendorsState>(
          builder: (context, state) {
            if (state is LoadVendorsSuccessful) {
              final vendors = state.items;
              final userDataSource = VendorsDataSource(
                  onViewClick: (int id) {
                    var user =
                    vendors.firstWhere((element) => element.vendorId == id);
                    context
                        .read<DashboardScreenBloc>()
                        .add(ToggleUserDetailPage(userId: id));
                  }, items: vendors, onEditClick: (int id) {  }, onDeleteClick: (int id) {  });
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: SfDataGridTheme(
                  data: SfDataGridThemeData(
                      headerColor: Theme.of(context)
                          .colorScheme
                          .primaryContainer),

                  child: SfDataGrid(
                      rowHeight: 50,

                      headerRowHeight: 30,
                      footer: vendors.isEmpty
                          ? const Center(
                        child: Text("No data available"),
                      )
                          : null,
                      gridLinesVisibility: GridLinesVisibility.horizontal,
                      rowsPerPage: 10,
                      headerGridLinesVisibility:
                      GridLinesVisibility.horizontal,
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
                            columnName: 'name',
                            columnWidthMode: ColumnWidthMode.fill,
                            label: Container(
                                alignment: Alignment.centerLeft,
                                padding: const EdgeInsets.symmetric(horizontal: 8),
                                child: const Text('Name'))),
                        GridColumn(
                            columnName: 'bank',
                            columnWidthMode: ColumnWidthMode.fill,
                            label: Container(
                                alignment: Alignment.centerLeft,
                                padding: const EdgeInsets.symmetric(horizontal: 8),
                                child: const Text('Bank'))),
                        GridColumn(
                            allowFiltering: false,
                            columnName: 'mobile_no',
                            allowSorting: false,
                            columnWidthMode: ColumnWidthMode.fill,
                            label: Container(
                                alignment: Alignment.centerLeft,
                                padding: const EdgeInsets.symmetric(horizontal: 8),
                                child: const Text('Mobile No'))),
                        GridColumn(
                            allowFiltering: false,
                            columnName: 'email',
                            columnWidthMode: ColumnWidthMode.fill,
                            label: Container(
                                alignment: Alignment.centerLeft,
                                padding: const EdgeInsets.symmetric(horizontal: 8),
                                child: const Text(
                                  'Email',
                                  softWrap: false,
                                ))),
                        GridColumn(
                            columnName: 'is_active',
                            allowSorting: false,
                            columnWidthMode: ColumnWidthMode.fill,
                            label: Container(
                                alignment: Alignment.centerLeft,
                                padding: const EdgeInsets.symmetric(horizontal: 8),
                                child: const Text(
                                  'Active',
                                  softWrap: false,

                                ))),
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
            if (state is LoadingVendors) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is LoadVendorsFailed) {
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
          }
        )
      ],
    );
  }
}
