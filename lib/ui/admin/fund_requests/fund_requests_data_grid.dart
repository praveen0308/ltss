import 'package:flutter/material.dart';
import 'package:ltss/models/api/entity/bank_entity.dart';
import 'package:ltss/models/api/entity/fund_request_entity.dart';
import 'package:ltss/models/api/entity/user_entity.dart';
import 'package:ltss/utils/user_type.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class FundRequestsDataSource extends DataGridSource {
  FundRequestsDataSource({
    required List<FundRequestEntity> items,
    required this.onRejected,
    required this.onAccepted,
  }) {
    _items = items
        .map<DataGridRow>((e) => DataGridRow(cells: [
              DataGridCell<int>(columnName: 'request_id', value: e.requestId),
              DataGridCell<String>(columnName: 'role', value: UserRole.getUserRoleName(e.sender?.roleId)),
              DataGridCell<String>(columnName: 'sender', value: e.sender!.name),
              DataGridCell<num>(columnName: 'amount', value: e.amount),
              DataGridCell<String>(columnName: 'status', value: e.status),
              const DataGridCell<Widget>(columnName: 'reject', value: null),
              const DataGridCell<Widget>(columnName: 'accept', value: null),
            ]))
        .toList();
  }

  List<DataGridRow> _items = [];
  final Function(int id) onRejected;
  final Function(int id) onAccepted;

  @override
  List<DataGridRow> get rows => _items;

  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((dataGridCell) {
      return Container(
        alignment: (dataGridCell.columnName == 'id')
            ? Alignment.center
            : Alignment.centerLeft,
        padding: const EdgeInsets.all(8.0),
        child: dataGridCell.columnName == 'reject'
            ? IconButton(
                onPressed: () {
                  onRejected(row.getCells()[0].value);
                },
                icon: const Icon(
                  Icons.close,
                  color: Colors.red,
                ))
            : dataGridCell.columnName == 'accept'
                ? IconButton(
                    onPressed: () {
                      onAccepted(row.getCells()[0].value);
                    },
                    icon: const Icon(
                      Icons.check,
                      color: Colors.green,
                    ))
                : Text(dataGridCell.value.toString()),
      );
    }).toList());
  }
}
