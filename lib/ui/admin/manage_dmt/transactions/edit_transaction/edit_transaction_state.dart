part of 'edit_transaction_cubit.dart';

enum EditTransactionStatus {
  initial,
  initializing,
  initializationSuccess,
  initializationFailed,
  loading,
  success,
  error,
  ;
}

extension EditTransactionStatusX on EditTransactionStatus {
  bool get isInitial => this == EditTransactionStatus.initial;

  bool get isInitializing => this == EditTransactionStatus.initializing;

  bool get isInitializationSuccessful =>
      this == EditTransactionStatus.initializationSuccess;

  bool get isInitializationFailed =>
      this == EditTransactionStatus.initializationFailed;

  bool get isSuccess => this == EditTransactionStatus.success;

  bool get isError => this == EditTransactionStatus.error;

  bool get isLoading => this == EditTransactionStatus.loading;
}

class EditTransactionState {
  const EditTransactionState({
    this.status = EditTransactionStatus.initial,
    this.msg,
  });

  final EditTransactionStatus status;
  final String? msg;

  EditTransactionState copyWith({
    EditTransactionStatus? status,
    String? msg,
  }) {
    return EditTransactionState(
      status: status ?? this.status,
      msg: msg ?? this.msg,
    );
  }
}
