import 'package:flutter/material.dart';
import 'package:ltss/models/api/entity/dmt_transaction.dart';

class TransactionsPage extends StatefulWidget {
  const TransactionsPage({super.key});

  @override
  State<TransactionsPage> createState() => _TransactionsPageState();
}

class _TransactionsPageState extends State<TransactionsPage> {
  final List<DmtTransaction> items = List.empty(growable: false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Transactions"),
        automaticallyImplyLeading: false,
      ),
      body: ListView.separated(
          itemBuilder: (context, index) {
            final transaction = items[index];
            return ListTile();
          },
          separatorBuilder: (context, index) {
            return const Divider();
          },
          itemCount: items.length),
    );
  }
}
