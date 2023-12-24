part of 'transactions_page_cubit.dart';

sealed class TransactionsPageState {}

class TransactionsPageInitial extends TransactionsPageState {}
class LoadingTransactions extends TransactionsPageState {}
class ReceivedTransactions extends TransactionsPageState {
  final List<DmtTransaction> transactions;

  ReceivedTransactions(this.transactions);
}
class LoadTransactionsFailed extends TransactionsPageState {
  final String msg;

  LoadTransactionsFailed(this.msg);
}
