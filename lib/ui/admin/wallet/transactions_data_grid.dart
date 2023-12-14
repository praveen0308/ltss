import 'package:flutter/material.dart';
import 'package:ltss/models/api/entity/dmt_transaction.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class TransactionsDataSource extends DataGridSource {
  TransactionsDataSource({required List<DmtTransaction> transactions}) {
    _items = transactions
        .map<DataGridRow>((e) => DataGridRow(cells: [
      DataGridCell<int>(columnName: 'id', value: e.transactionId),
      DataGridCell<int>(columnName: 'serviceId', value: e.serviceId),
      DataGridCell<int>(
          columnName: 'customerId', value: e.bankId),
      DataGridCell<int>(
          columnName: 'bankId', value: e.bankId),
      DataGridCell<String>(columnName: 'amount', value: e.amount.toString()),
      DataGridCell<String>(columnName: 'status', value: e.status.toString()),
      DataGridCell<int>(columnName: 'addedBy', value: e.addedBy),
    ]))
        .toList();
  }

  List<DataGridRow>  _items = [];

  @override
  List<DataGridRow> get rows =>  _items;

  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((dataGridCell) {
          return Container(
            alignment: (dataGridCell.columnName == 'id')
                ? Alignment.center
                : Alignment.centerLeft,
            padding: const EdgeInsets.all(8.0),
            child: Text(dataGridCell.value.toString()),
          );
        }).toList());
  }
}