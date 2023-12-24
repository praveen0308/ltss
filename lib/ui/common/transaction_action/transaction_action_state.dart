part of 'transaction_action_cubit.dart';

sealed class TransactionActionState {}

class TransactionActionInitial extends TransactionActionState {}

class Initializing extends TransactionActionState {}

class InitializationSuccessful extends TransactionActionState {
  final bool uploadSsEnabled;
  final bool commentEnabled;
  final String buttonText;
  final TransactionEntity? transactionDetail;
  final Tracking? tracking;

  InitializationSuccessful(this.transactionDetail, this.uploadSsEnabled,
      this.commentEnabled, this.buttonText, this.tracking);
}

class InitializationFailed extends TransactionActionState {
  final String msg;

  InitializationFailed(this.msg);
}

class Updating extends TransactionActionState {}

class UpdateSuccessful extends TransactionActionState {}

class UpdateFailed extends TransactionActionState {
  final String msg;

  UpdateFailed(this.msg);
}
