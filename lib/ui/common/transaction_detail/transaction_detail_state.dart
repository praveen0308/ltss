part of 'transaction_detail_cubit.dart';

@immutable
abstract class TransactionDetailState {}

class TransactionDetailInitial extends TransactionDetailState {}
class Initializing extends TransactionDetailState {}
class InitializationSuccessful extends TransactionDetailState {
  final bool canAccept;
  final bool canReject;
  final bool canMarkVerified;

  InitializationSuccessful(this.canAccept, this.canReject, this.canMarkVerified);
}
class InitializationFailed extends TransactionDetailState {}
