part of 'add_bank_cubit.dart';

enum AddBankStatus {
  initial,
  loading,
  success,
  error,
  ;
}

extension AddBankStatusX on AddBankStatus {
  bool get isInitial => this == AddBankStatus.initial;

  bool get isSuccess => this == AddBankStatus.success;

  bool get isError => this == AddBankStatus.error;

  bool get isLoading => this == AddBankStatus.loading;
}

class AddBankState {
  const AddBankState({
    this.status = AddBankStatus.initial,
    this.msg
  });

  final AddBankStatus status;
  final String? msg;

  AddBankState copyWith({
    AddBankStatus? status,
    String? msg,
  }) {
    return AddBankState(
      status: status ?? this.status,
      msg: msg ?? this.msg,
    );
  }
}
