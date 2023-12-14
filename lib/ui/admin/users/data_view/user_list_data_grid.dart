import 'package:flutter/material.dart';
import 'package:ltss/models/api/entity/user_entity.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class UserDataSource extends DataGridSource {
  UserDataSource({required List<UserEntity> users, required this.onViewClick}) {
    _users = users
        .map<DataGridRow>((e) => DataGridRow(cells: [
              DataGridCell<int>(columnName: 'id', value: e.id),
              DataGridCell<String>(columnName: 'first_name', value: e.firstName),
              DataGridCell<String>(columnName: 'last_name', value: e.lastName),
              DataGridCell<String>(columnName: 'mobile_no', value: e.mobileNo),
              DataGridCell<String>(columnName: 'email', value: e.email),
              const DataGridCell<Widget>(columnName: 'view', value: null),
            ]))
        .toList();
  }

  List<DataGridRow> _users = [];
  final Function(int id) onViewClick;

  @override
  List<DataGridRow> get rows => _users;

  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((dataGridCell) {
      return Container(
        alignment: (dataGridCell.columnName == 'id')
            ? Alignment.center
            : Alignment.centerLeft,
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child:dataGridCell.columnName == 'view'
            ? IconButton(
          alignment: Alignment.topCenter,
            onPressed: () {
              onViewClick(row.getCells()[0].value);
            },
            icon: const Icon(Icons.remove_red_eye_rounded,size: 16,))

            : Text(dataGridCell.value.toString(),style:const TextStyle(fontSize: 14),),
      );
    }).toList());
  }
}
