part of 'add_commission_cubit.dart';

enum AddCommissionStatus {
  initial,
  initializing,
  initializationSuccess,
  initializationFailed,
  loading,
  success,
  error,
  ;
}

extension AddCommissionStatusX on AddCommissionStatus {
  bool get isInitial => this == AddCommissionStatus.initial;

  bool get isInitializing => this == AddCommissionStatus.initializing;

  bool get isInitializationSuccessful =>
      this == AddCommissionStatus.initializationSuccess;

  bool get isInitializationFailed =>
      this == AddCommissionStatus.initializationFailed;

  bool get isSuccess => this == AddCommissionStatus.success;

  bool get isError => this == AddCommissionStatus.error;

  bool get isLoading => this == AddCommissionStatus.loading;
}

class AddCommissionState {
  const AddCommissionState({
    this.status = AddCommissionStatus.initial,
    this.msg,
    this.services,
  });

  final AddCommissionStatus status;
  final String? msg;
  final List<ServiceEntity>? services;

  AddCommissionState copyWith({
    AddCommissionStatus? status,
    String? msg,
    List<ServiceEntity>? services
  }) {
    return AddCommissionState(
      status: status ?? this.status,
      msg: msg ?? this.msg,
      services: services ?? this.services,
    );
  }
}
