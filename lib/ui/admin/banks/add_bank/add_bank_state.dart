part of 'add_bank_cubit.dart';

enum AddBankStatus {
  initial,
  initialising,
  initialisationSuccessful,
  initialisationFailed,
  loading,
  success,
  error,
  ;
}

extension AddBankStatusX on AddBankStatus {
  bool get isInitial => this == AddBankStatus.initial;
  bool get isInitialising => this == AddBankStatus.initialising;
  bool get isInitialisationSuccessful => this == AddBankStatus.initialisationSuccessful;
  bool get isInitialisationFailed => this == AddBankStatus.initialisationFailed;

  bool get isSuccess => this == AddBankStatus.success;

  bool get isError => this == AddBankStatus.error;

  bool get isLoading => this == AddBankStatus.loading;
}

class AddBankState {
  const AddBankState( {
    this.status = AddBankStatus.initial,
    this.msg,
    this.vendors,
    this.assignedVendor
  });

  final AddBankStatus status;
  final String? msg;
  final List<UserEntity>? vendors;
  final UserEntity? assignedVendor;

  AddBankState copyWith({
    AddBankStatus? status,
    String? msg,
    List<UserEntity>? vendors,
    UserEntity? assignedVendor,
  }) {
    return AddBankState(
      status: status ?? this.status,
      msg: msg ?? this.msg,
      vendors: vendors ?? this.vendors,
      assignedVendor: assignedVendor ?? this.assignedVendor,
    );
  }
}
