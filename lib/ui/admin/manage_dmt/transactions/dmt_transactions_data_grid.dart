import 'package:flutter/material.dart';
import 'package:ltss/models/api/entity/bank_vendor.dart';
import 'package:ltss/models/api/entity/dmt_transaction.dart';
import 'package:ltss/models/api/entity/user_entity.dart';
import 'package:ltss/ui/widgets/view_highlighted_label.dart';
import 'package:ltss/ui/widgets/view_status.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class DmtTransactionsDataSource extends DataGridSource {
  DmtTransactionsDataSource(
      {required List<DmtTransaction> items,
      required this.onViewClick,
      required this.onEditClick,
      required this.onDeleteClick}) {
    _items = items
        .map<DataGridRow>((e) => DataGridRow(cells: [
              DataGridCell<int>(columnName: 'id', value: e.transactionId),
              /*DataGridCell<String>(
                  columnName: 'sender_name', value: e.senderName),
              DataGridCell<String>(columnName: 'sender_mobile_no', value: e.senderMobileNo),*/
              DataGridCell<String>(
                  columnName: 'customer', value: e.getCustomer()),
              /*DataGridCell<String>(
                  columnName: 'beneficiary_id', value: e.beneficiaryId),
              DataGridCell<String>(columnName: 'beneficiary_name', value: e.beneficiaryName),
              DataGridCell<String>(columnName: 'account_number', value: e.accountNumber),
              DataGridCell<String>(columnName: 'ifsc', value: e.ifsc),*/
              DataGridCell<String>(
                  columnName: 'beneficiary', value: e.getBeneficiary()),
      DataGridCell<String>(
                  columnName: 'retailer', value: e.getRetailer()),
      DataGridCell<String>(
                  columnName: 'vendor', value: e.getVendor()),
              DataGridCell<int>(columnName: 'bank_id', value: e.bankId),
              DataGridCell<String>(columnName: 'bank_name', value: e.bankName),
              DataGridCell<String>(
                  columnName: 'trans_mode', value: e.getTransMode()),
              DataGridCell<double>(columnName: 'amount', value: e.amount),
              DataGridCell<double>(
                  columnName: 'commission', value: e.commission),
              DataGridCell<double>(columnName: 'charge', value: e.charge),
              DataGridCell<String>(columnName: 'status', value: e.status),
              DataGridCell<String>(columnName: 'comment', value: e.comment),
              DataGridCell<String>(
                  columnName: 'added_on', value: e.getFormattedAddedOn()),
              DataGridCell<String>(
                  columnName: 'modified_on', value: e.getFormattedModifiedOn()),
              DataGridCell<int>(columnName: 'added_by', value: e.addedBy),
              DataGridCell<int>(columnName: 'modified_by', value: e.modifiedBy),
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
            ? Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  IconButton(
                    onPressed: () => onViewClick(row.getCells()[0].value),
                    icon: const Icon(Icons.remove_red_eye_rounded),
                    iconSize: 16,
                    splashRadius: 0.0001,
                    padding: EdgeInsets.zero,
                    constraints:
                        const BoxConstraints(minWidth: 24, maxWidth: 24),
                  ),
                  IconButton(
                    onPressed: () => onEditClick(row.getCells()[0].value),
                    icon: const Icon(Icons.edit),
                    iconSize: 16,
                    splashRadius: 0.0001,
                    padding: EdgeInsets.zero,
                    constraints:
                        const BoxConstraints(minWidth: 24, maxWidth: 24),
                  ),
                  IconButton(
                    onPressed: () => onDeleteClick(row.getCells()[0].value),
                    icon: const Icon(Icons.delete),
                    iconSize: 16,
                    splashRadius: 0.0001,
                    padding: EdgeInsets.zero,
                    constraints:
                        const BoxConstraints(minWidth: 24, maxWidth: 24),
                  ),
                  /*  IconButton(onPressed: (){}, icon: Icon(Icons.block_rounded),iconSize: 16,splashRadius: 0.0001,
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(minWidth: 24, maxWidth: 24),),*/
                ],
              )
            : dataGridCell.columnName == 'status'
                ? StatusView(status: dataGridCell.value != "REQUESTED",text: dataGridCell.value,)
                : dataGridCell.columnName == 'amount' ||
                        dataGridCell.columnName == 'commission' ||
                        dataGridCell.columnName == 'charge'
                    ? Text(
                        "₹${dataGridCell.value.toString()}",
                        style: const TextStyle(
                            fontSize: 13, fontWeight: FontWeight.w500),
                      )
                    : Text(
                        dataGridCell.value==null ? "-":dataGridCell.value.toString() ,
                        style: const TextStyle(
                            fontSize: 13, fontWeight: FontWeight.w500),
                      ),
      );
    }).toList());
  }
}
