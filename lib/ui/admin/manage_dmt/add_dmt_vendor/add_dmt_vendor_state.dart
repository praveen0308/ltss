part of 'add_dmt_vendor_cubit.dart';


enum AddDmtVendorStatus {
  initial,
  initializing,
  initializationSuccess,
  initializationFailed,
  loading,
  success,
  error,
  ;
}

extension AddDmtVendorStatusX on AddDmtVendorStatus {
  bool get isInitial => this == AddDmtVendorStatus.initial;

  bool get isInitializing => this == AddDmtVendorStatus.initializing;

  bool get isInitializationSuccessful =>
      this == AddDmtVendorStatus.initializationSuccess;

  bool get isInitializationFailed =>
      this == AddDmtVendorStatus.initializationFailed;

  bool get isSuccess => this == AddDmtVendorStatus.success;

  bool get isError => this == AddDmtVendorStatus.error;

  bool get isLoading => this == AddDmtVendorStatus.loading;
}

class AddDmtVendorState {
  const AddDmtVendorState({
    this.status = AddDmtVendorStatus.initial,
    this.msg,
    this.banks,
  });

  final AddDmtVendorStatus status;
  final String? msg;
  final List<BankEntity>? banks;

  AddDmtVendorState copyWith({
    AddDmtVendorStatus? status,
    String? msg,
    List<BankEntity>? banks
  }) {
    return AddDmtVendorState(
      status: status ?? this.status,
      msg: msg ?? this.msg,
      banks: banks ?? this.banks,
    );
  }
}
