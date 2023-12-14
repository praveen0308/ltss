import 'package:flutter/material.dart';
import 'package:ltss/models/api/entity/bank_vendor.dart';
import 'package:ltss/models/api/entity/user_entity.dart';
import 'package:ltss/ui/widgets/view_highlighted_label.dart';
import 'package:ltss/ui/widgets/view_status.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class VendorsDataSource extends DataGridSource {
  VendorsDataSource(
      {required List<BankVendor> items, required this.onViewClick,required this.onEditClick,required this.onDeleteClick}) {
    _items = items
        .map<DataGridRow>((e) => DataGridRow(cells: [
              DataGridCell<int>(columnName: 'id', value: e.vendorId),
              DataGridCell<String>(
                  columnName: 'name', value: e.vendor?.getName()),
              DataGridCell<String>(columnName: 'bank', value: e.bank?.name),
              DataGridCell<String>(
                  columnName: 'mobile_no', value: e.vendor?.mobileNo),
              DataGridCell<String>(columnName: 'email', value: e.vendor?.email),
              DataGridCell<bool>(
                  columnName: 'is_active', value: e.vendor?.isActive),
              const DataGridCell<Widget>(columnName: 'actions', value: null),
            ]))
        .toList();
  }

  List<DataGridRow> _items = [];
  final Function(int id) onViewClick;
  final Function(int id) onEditClick;
  final Function(int id) onDeleteClick;

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
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: dataGridCell.columnName == 'actions'
            ? Row(mainAxisAlignment: MainAxisAlignment.start,children: [
              IconButton(onPressed: ()=>onViewClick(row.getCells()[0].value), icon: Icon(Icons.remove_red_eye_rounded),iconSize: 16,splashRadius: 0.0001,
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(minWidth: 24, maxWidth: 24),),
              IconButton(onPressed: ()=> onEditClick(row.getCells()[0].value), icon: Icon(Icons.edit),iconSize: 16,splashRadius: 0.0001,
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(minWidth: 24, maxWidth: 24),),
              IconButton(onPressed:()=>  onDeleteClick(row.getCells()[0].value), icon: Icon(Icons.delete),iconSize: 16,splashRadius: 0.0001,
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(minWidth: 24, maxWidth: 24),),
            /*  IconButton(onPressed: (){}, icon: Icon(Icons.block_rounded),iconSize: 16,splashRadius: 0.0001,
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(minWidth: 24, maxWidth: 24),),*/
        ],)
            : dataGridCell.columnName == 'is_active'
                ? StatusView(status: dataGridCell.value == true)
                : Text(
                    dataGridCell.value.toString(),
                    style: const TextStyle(fontSize: 13,fontWeight: FontWeight.w500),
                  ),
      );
    }).toList());
  }
}
