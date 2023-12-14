import 'package:flutter/material.dart';
import 'package:ltss/models/api/entity/bank_entity.dart';
import 'package:ltss/models/api/entity/fund_request_entity.dart';
import 'package:ltss/models/api/entity/user_entity.dart';
import 'package:ltss/utils/user_type.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class FundRequestsHistoryDataSource extends DataGridSource {
  FundRequestsHistoryDataSource({
    required List<FundRequestEntity> items
  }) {
    _items = items
        .map<DataGridRow>((e) => DataGridRow(cells: [
              DataGridCell<int>(columnName: 'request_id', value: e.requestId),
              DataGridCell<String>(columnName: 'role', value: UserRole.getUserRoleName(e.sender?.roleId)),
              DataGridCell<String>(columnName: 'sender', value: e.sender!.name),
              DataGridCell<num>(columnName: 'amount', value: e.amount),
              DataGridCell<String>(columnName: 'status', value: e.status)
            ]))
        .toList();
  }

  List<DataGridRow> _items = [];
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
        child: Text(dataGridCell.value.toString()),
      );
    }).toList());
  }
}
