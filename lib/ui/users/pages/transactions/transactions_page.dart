import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ltss/base/base.dart';
import 'package:ltss/models/enums.dart';
import 'package:ltss/routes/route_imports.gr.dart';
import 'package:ltss/ui/users/pages/transactions/transactions_page_cubit.dart';
import 'package:ltss/ui/widgets/view_error_page.dart';
import 'package:ltss/ui/widgets/view_highlighted_label.dart';
import 'package:ltss/ui/widgets/view_loading.dart';

class TransactionsPage extends StatefulWidget {
  const TransactionsPage({super.key});

  @override
  State<TransactionsPage> createState() => _TransactionsPageState();
}

class _TransactionsPageState extends State<TransactionsPage> {
  @override
  void initState() {
    context.read<TransactionsPageCubit>().fetchTransactions();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Transactions"),
        automaticallyImplyLeading: false,
      ),
      body: BlocConsumer<TransactionsPageCubit, TransactionsPageState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          switch (state) {
            case TransactionsPageInitial():
              return const LoadingView();
            case LoadingTransactions():
              return const LoadingView();
            case ReceivedTransactions():
              {
                if(state.transactions.isNotEmpty){
                  return ListView.separated(
                      itemBuilder: (context, index) {
                        final transaction = state.transactions[index];
                        final status = AppStatus.fromString(transaction.status);
                        return ListTile(
                          onTap: (){
                            AutoRouter.of(context).push(TransactionDetailRoute(transaction: transaction));
                          },
                          title: Row(
                            children: [
                              CircleAvatar(child: Text(transaction.getCustomer().take(1)),),
                              const SizedBox(width: 16,),
                              Text(transaction.getCustomer()),
                            ],
                          ),
                          subtitle: Column(
                            children: [
                              Text(transaction.getFormattedAddedOn())
                            ],
                          ),
                          trailing: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              HighlightedLabel(
                                text: status.name,
                                bgColor: status.bgColor,
                                textColor: status.textColor,
                              ),
                              Text("₹${transaction.amount}",style: const TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),)
                            ],
                          ),
                        );
                      },
                      separatorBuilder: (context, index) {
                        return const Divider();
                      },
                      itemCount: state.transactions.length);
                }else{
                  return const ErrorPageView(
                    msg: "No transactions found!!",
                  );
                }

              }
            case LoadTransactionsFailed():
              return ErrorPageView(msg: state.msg);
          }
        },
      ),
    );
  }
}
