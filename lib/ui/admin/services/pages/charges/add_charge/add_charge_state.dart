part of 'add_charge_cubit.dart';

enum AddChargeStatus{
  initial,loading,success,error,
  initializing,
  initializationSuccess,
  initializationFailed;
}
extension AddChargeStatusX on AddChargeStatus {
  bool get isInitial => this == AddChargeStatus.initial;
  bool get isSuccess => this == AddChargeStatus.success;
  bool get isError => this == AddChargeStatus.error;
  bool get isLoading => this == AddChargeStatus.loading;
  bool get isInitializing => this == AddChargeStatus.initializing;

  bool get isInitializationSuccessful =>
      this == AddChargeStatus.initializationSuccess;

  bool get isInitializationFailed =>
      this == AddChargeStatus.initializationFailed;
}


class AddChargeState {
  const AddChargeState({
    this.status = AddChargeStatus.initial,
    this.msg,
    this.services,
  });

  final AddChargeStatus status;
  final String? msg;
  final List<ServiceEntity>? services;

  AddChargeState copyWith({
    AddChargeStatus? status,
    String? msg,
    List<ServiceEntity>? services
  }) {
    return AddChargeState(
      status: status ?? this.status,
      msg: msg ?? this.msg,
      services: services ?? this.services,
    );
  }
}
