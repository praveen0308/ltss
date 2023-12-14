import 'package:flutter/material.dart';
import 'package:ltss/models/api/entity/bank_entity.dart';
import 'package:ltss/models/api/entity/user_entity.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class BankDataSource extends DataGridSource {
  BankDataSource({
    required List<BankEntity> items,
    required this.onUpdate,
    required this.onDelete,
  }) {
    _items = items
        .map<DataGridRow>((e) => DataGridRow(cells: [
              DataGridCell<int>(columnName: 'bank_id', value: e.bankId),
              DataGridCell<int>(columnName: 'code', value: e.code),
              DataGridCell<String>(columnName: 'name', value: e.name),
              DataGridCell<String>(columnName: 'ifsc', value: e.ifsc),
              DataGridCell<num>(columnName: 'min', value: e.min),
              DataGridCell<num>(columnName: 'max', value: e.max),
              DataGridCell<bool>(columnName: 'is_active', value: e.isActive),
              const DataGridCell<Widget>(columnName: 'update', value: null),
              const DataGridCell<Widget>(columnName: 'delete', value: null),
            ]))
        .toList();
  }

  List<DataGridRow> _items = [];
  final Function(int id) onUpdate;
  final Function(int id) onDelete;

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
        padding: const EdgeInsets.all(0.0),
        child: dataGridCell.columnName == 'update'
            ? IconButton(
                onPressed: () {
                  onUpdate(row.getCells()[0].value);
                },
                icon: const Icon(Icons.edit))
            : dataGridCell.columnName == 'delete'
                ? IconButton(
                    onPressed: () {
                      onDelete(row.getCells()[0].value);
                    },
                    icon: const Icon(
                      Icons.delete,
                      color: Colors.red,
                    ))
                : Text(dataGridCell.value.toString()),
      );
    }).toList());
  }
}
