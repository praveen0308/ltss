part of 'dmt_checkout_cubit.dart';

enum DmtCheckoutStatus {
  initial,
  initializing,
  initializationSuccess,
  initializationFailed,
  loading,
  success,
  error,
  ;
}

extension DmtCheckoutStatusX on DmtCheckoutStatus {
  bool get isInitial => this == DmtCheckoutStatus.initial;

  bool get isInitializing => this == DmtCheckoutStatus.initializing;

  bool get isInitializationSuccessful =>
      this == DmtCheckoutStatus.initializationSuccess;

  bool get isInitializationFailed =>
      this == DmtCheckoutStatus.initializationFailed;

  bool get isSuccess => this == DmtCheckoutStatus.success;

  bool get isError => this == DmtCheckoutStatus.error;

  bool get isLoading => this == DmtCheckoutStatus.loading;
}

class DmtCheckoutState {
  const DmtCheckoutState({
    this.status = DmtCheckoutStatus.initial,
    this.msg,
    this.amount = 0,
    this.applicableCharges = 0,
    this.total = 0,
    this.canProceed = false,
    this.amountValidationError
  });

  final DmtCheckoutStatus status;
  final String? msg;
  final double amount;
  final double applicableCharges;
  final double total;
  final bool canProceed;
  final String? amountValidationError;

  DmtCheckoutState copyWith({
    DmtCheckoutStatus? status,
    String? msg,
    double? amount,
    double? applicableCharges,
    double? total,
    bool? canProceed,
    String? amountValidationError,
  }) {
    return DmtCheckoutState(
      status: status ?? this.status,
      msg: msg ?? this.msg,
      amount: amount ?? this.amount,
      applicableCharges: applicableCharges ?? this.applicableCharges,
      total: total ?? this.total,
      canProceed: canProceed ?? this.canProceed,
      amountValidationError: amountValidationError,
    );
  }
}
