import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ltss/base/base.dart';
import 'package:ltss/models/api/entity/wallet_ledger_entity.dart';
import 'package:ltss/ui/admin/wallet/wallet_screen_cubit.dart';
import 'package:ltss/ui/widgets/widgets.dart';
import 'package:shimmer/shimmer.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import 'package:intl/intl.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({super.key});

  static Widget create() {
    return BlocProvider(
      create: (context) => WalletScreenCubit(
        RepositoryProvider.of<WalletRepository>(context),
        RepositoryProvider.of<DMTRepository>(context),
      )..loadWalletBalance(),
      child: const WalletScreen(),
    );
  }

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> with BasePageState {
  bool showLoadingIndicator = true;
  final int _rowsPerPage = 10;

  final List<WalletLedgerEntity> _ledgerEntries = [];
  final double _dataPagerHeight = 60.0;

  late WalletLedgerDataSource _walletLedgerDataSource;

  @override
  void initState() {
    context.read<WalletScreenCubit>().loadWalletBalance();

    _walletLedgerDataSource =
        WalletLedgerDataSource(onPageChanged: (start, end) {
      context.read<WalletScreenCubit>().loadWalletLedger(end, _rowsPerPage);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<WalletScreenCubit, WalletScreenState>(
      listener: (context, state) {
        if (state is ReceivedWalletStats) {
          context.read<WalletScreenCubit>().loadWalletLedger(0, _rowsPerPage);
        }
        showLoadingIndicator = state is LoadingRecentTransactions;

        if (state is ReceivedRecentTransactions) {
          _ledgerEntries.addAll(state.entries);
          _walletLedgerDataSource.updateEntries(
              _ledgerEntries, state.skip, _ledgerEntries.length);
        }
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          BlocBuilder<WalletScreenCubit, WalletScreenState>(
            builder: (context, state) {
              if (state is LoadingWalletStats) {
                return Shimmer.fromColors(
                    baseColor: Theme.of(context).colorScheme.primaryContainer,
                    highlightColor:
                        Theme.of(context).colorScheme.inversePrimary,
                    child: Row(
                      children: [
                        Container(
                          width: 150,
                          height: 80,
                          margin: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(8)),
                        ),
                        Container(
                          width: 150,
                          height: 80,
                          margin: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(8)),
                        ),
                      ],
                    ));
              }
              if (state is LoadWalletStatsFailed) {
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
              if (state is ReceivedWalletStats) {
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
                              child: ListTile(
                                visualDensity: const VisualDensity(
                                    horizontal: 0, vertical: -4),
                                title: const Text("User Wallet"),
                                trailing: Text(
                                    "₹${state.userWallet()?.balance ?? 0}"),
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.all(2),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all()),
                              child: ListTile(
                                visualDensity: const VisualDensity(
                                    horizontal: 0, vertical: -4),
                                title: const Text("Service Wallet"),
                                trailing: Text(
                                    "₹${state.serviceWallet()?.balance ?? 0}"),
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.all(2),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all()),
                              child: ListTile(
                                visualDensity: const VisualDensity(
                                    horizontal: 0, vertical: -4),
                                title: const Text("Vendor Wallet"),
                                trailing: Text(
                                    "₹${state.vendorWallet()?.balance ?? 0}"),
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
          Expanded(
            child: BlocBuilder<WalletScreenCubit, WalletScreenState>(
              builder: (context, state) {
                /*if (state is LoadingRecentTransactions) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }*/
                if (state is LoadRecentTransactionsFailed) {
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
                if (state is ReceivedRecentTransactions) {
                  return LayoutBuilder(builder: (context, constraints) {
                    return Row(children: [
                      Column(children: [
                        SizedBox(
                            height: constraints.maxHeight - 60,
                            width: constraints.maxWidth,
                            child: _buildStack(constraints)),
                        Container(
                            height: 60,
                            width: constraints.maxWidth,
                            child: SfDataPager(
                                pageCount: state.totalCount / _rowsPerPage,
                                direction: Axis.horizontal,
                                onPageNavigationStart: (int pageIndex) {
                                  /*setState(() {
                                  showLoadingIndicator = true;
                                });*/
                                },
                                delegate: _walletLedgerDataSource,
                                onPageNavigationEnd: (int pageIndex) {
                                  /*setState(() {
                                  showLoadingIndicator = false;
                                });*/
                                }))
                      ])
                    ]);
                  });
                }
                return Container();
              },
              buildWhen: (prev, state) {
                return state is LoadingRecentTransactions ||
                    state is ReceivedRecentTransactions ||
                    state is LoadRecentTransactionsFailed;
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStack(BoxConstraints constraints) {
    List<Widget> _getChildren() {
      final List<Widget> stackChildren = [];
      stackChildren.add(_buildDataGrid(constraints));

      if (showLoadingIndicator) {
        stackChildren.add(Container(
            color: Colors.black12,
            width: constraints.maxWidth,
            height: constraints.maxHeight,
            child: const Align(
                alignment: Alignment.center,
                child: CircularProgressIndicator(
                  strokeWidth: 3,
                ))));
      }

      return stackChildren;
    }

    return Stack(
      children: _getChildren(),
    );
  }

  Widget _buildDataGrid(BoxConstraints constraint) {
    return SfDataGrid(
        source: _walletLedgerDataSource,
        columnWidthMode: ColumnWidthMode.fill,
        columns: <GridColumn>[
          GridColumn(
              columnName: 'ledger_id',
              label: Container(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  alignment: Alignment.centerRight,
                  child: Text(
                    'Ledger ID',
                    overflow: TextOverflow.ellipsis,
                  ))),
          GridColumn(
              columnName: 'debited_from',
              label: Container(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Customer Name',
                    overflow: TextOverflow.ellipsis,
                  ))),
          GridColumn(
              columnName: 'debit_wallet_type',
              label: Container(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  alignment: Alignment.centerRight,
                  child: Text(
                    'Debit Wallet Type',
                    overflow: TextOverflow.ellipsis,
                  ))),
          GridColumn(
              columnName: 'credited_into',
              label: Container(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  alignment: Alignment.center,
                  child: Text(
                    'Credited Into',
                    overflow: TextOverflow.ellipsis,
                  ))),
          GridColumn(
              columnName: 'credit_wallet_type',
              label: Container(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  alignment: Alignment.center,
                  child: Text(
                    'Credit Wallet Type',
                    overflow: TextOverflow.ellipsis,
                  ))),
          GridColumn(
              columnName: 'amount',
              label: Container(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  alignment: Alignment.center,
                  child: Text(
                    'Amount',
                    overflow: TextOverflow.ellipsis,
                  ))),
          GridColumn(
              columnName: 'type',
              label: Container(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  alignment: Alignment.center,
                  child: Text(
                    'Type',
                    overflow: TextOverflow.ellipsis,
                  ))),
          GridColumn(
              columnName: 'reference_id',
              label: Container(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  alignment: Alignment.center,
                  child: Text(
                    'Reference ID',
                    overflow: TextOverflow.ellipsis,
                  ))),
          GridColumn(
              columnName: 'added_on',
              label: Container(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  alignment: Alignment.center,
                  child: Text(
                    'Added ON',
                    overflow: TextOverflow.ellipsis,
                  ))),
        ]);
  }
}

class WalletLedgerDataSource extends DataGridSource {
  final int _rowsPerPage = 10;

  final List<WalletLedgerEntity> _ledgerEntries = [];

  List<WalletLedgerEntity> _paginatedEntries = [];
  final Function(int start, int end) onPageChanged;

  WalletLedgerDataSource({required this.onPageChanged}) {
/*
    if(_ledgerEntries.isNotEmpty){
      _paginatedEntries =
          _ledgerEntries.getRange(0, _rowsPerPage).toList(growable: false);
      buildPaginatedDataGridRows();
    }
*/
  }

  List<DataGridRow> dataGridRows = [];

  @override
  List<DataGridRow> get rows => dataGridRows;

  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((dataGridCell) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        alignment: Alignment.centerRight,
        child: Text(
          dataGridCell.value.toString(),
          overflow: TextOverflow.ellipsis,
        ),
      );
    }).toList());
  }

  void updateEntries(List<WalletLedgerEntity> entries, int start, int end) {
    _ledgerEntries.addAll(entries);
    _paginatedEntries =
        _ledgerEntries.getRange(start, end).toList(growable: false);
    buildPaginatedDataGridRows();
    notifyListeners();
  }

  @override
  Future<bool> handlePageChange(int oldPageIndex, int newPageIndex) async {
    int startIndex = newPageIndex * _rowsPerPage;
    int endIndex = startIndex + _rowsPerPage;

    if (newPageIndex > oldPageIndex) {
      onPageChanged(startIndex, endIndex);
    } else {
      _paginatedEntries =
          _ledgerEntries.getRange(startIndex, endIndex).toList(growable: false);
      buildPaginatedDataGridRows();
      notifyListeners();
    }

    return true;
  }

  void buildPaginatedDataGridRows() {
    dataGridRows = _paginatedEntries.map<DataGridRow>((dataGridRow) {
      return DataGridRow(cells: [
        DataGridCell(columnName: 'ledger_id', value: dataGridRow.ledgerId),
        DataGridCell(
            columnName: 'debited_from', value: dataGridRow.debitedFrom),
        DataGridCell(
            columnName: 'debit_wallet_type',
            value: dataGridRow.debitWalletType),
        DataGridCell(
            columnName: 'credited_into', value: dataGridRow.creditedInto),
        DataGridCell(
            columnName: 'credit_wallet_type',
            value: dataGridRow.creditWalletType),
        DataGridCell(columnName: 'amount', value: dataGridRow.amount),
        DataGridCell(columnName: 'type', value: dataGridRow.type),
        DataGridCell(
            columnName: 'reference_id', value: dataGridRow.referenceId),
        DataGridCell(columnName: 'added_on', value: dataGridRow.addedOn),
      ]);
    }).toList(growable: false);
  }
}
