import 'package:flutter/material.dart';
import 'package:ltss/models/api/entity/charge_entity.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class ChargesDataSource extends DataGridSource {
  ChargesDataSource({required List<ChargeEntity> data, required this.onUpdate,
    required this.onDelete,}) {
    _items = data
        .map<DataGridRow>((e) => DataGridRow(cells: [
      DataGridCell<int>(columnName: 'id', value: e.chargeId),
      DataGridCell<int>(columnName: 'serviceId', value: e.serviceId),

      DataGridCell<String>(columnName: 'name', value: e.name),
      DataGridCell<String>(columnName: 'value', value: e.value),
      DataGridCell<String>(
          columnName: 'addedOn', value: e.addedOn),
      DataGridCell<bool>(
          columnName: 'isActive', value: e.isActive),
      const DataGridCell<Widget>(columnName: 'update', value: null),
      const DataGridCell<Widget>(columnName: 'delete', value: null),
    ]))
        .toList();
  }
  final Function(int id) onUpdate;
  final Function(int id) onDelete;
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
            padding: const EdgeInsets.all(2.0),
            child: dataGridCell.columnName == 'update'
                ? IconButton(onPressed: () {
              onUpdate(row.getCells()[0].value);
            }, icon: const Icon(Icons.edit))
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