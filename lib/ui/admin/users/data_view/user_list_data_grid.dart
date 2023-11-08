import 'package:flutter/material.dart';
import 'package:ltss/models/api/entity/user_entity.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class UserDataSource extends DataGridSource {
  UserDataSource({required List<UserEntity> users}) {
    _users = users
        .map<DataGridRow>((e) => DataGridRow(cells: [
      DataGridCell<int>(columnName: 'id', value: e.id),
      DataGridCell<String>(columnName: 'name', value: e.name),
      DataGridCell<String>(
          columnName: 'mobile_no', value: e.mobile_no),
      DataGridCell<String>(columnName: 'email', value: e.email),
    ]))
        .toList();
  }

  List<DataGridRow>  _users = [];

  @override
  List<DataGridRow> get rows =>  _users;

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