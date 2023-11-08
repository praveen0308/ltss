part of 'add_service_cubit.dart';

enum AddServiceStatus {
  initial,
  loading,
  success,
  error,
  ;
}

extension AddServiceStatusX on AddServiceStatus {
  bool get isInitial => this == AddServiceStatus.initial;

  bool get isSuccess => this == AddServiceStatus.success;

  bool get isError => this == AddServiceStatus.error;

  bool get isLoading => this == AddServiceStatus.loading;
}

class AddServiceState {
  const AddServiceState({
    this.status = AddServiceStatus.initial,
    this.msg,
  });

  final AddServiceStatus status;
  final String? msg;

  AddServiceState copyWith({
    AddServiceStatus? status,
    String? msg,
  }) {
    return AddServiceState(
      status: status ?? this.status,
      msg: msg ?? this.msg,
    );
  }
}
