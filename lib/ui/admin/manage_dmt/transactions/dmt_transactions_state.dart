part of 'dmt_transactions_cubit.dart';

@immutable
abstract class DmtTransactionsState {}

class DmtTransactionsInitial extends DmtTransactionsState {}
class LoadingTransactions extends DmtTransactionsState {}
class LoadTransactionsSuccessful extends DmtTransactionsState {
  final List<DmtTransaction> items;

  LoadTransactionsSuccessful(this.items);
}
class LoadTransactionsFailed extends DmtTransactionsState {
  final String msg;

  LoadTransactionsFailed(this.msg);

}

