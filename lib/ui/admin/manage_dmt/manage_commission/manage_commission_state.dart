part of 'manage_commission_cubit.dart';

sealed class ManageCommissionState {}

class ManageCommissionInitial extends ManageCommissionState {}
class LoadingData extends ManageCommissionState {}
class LoadDataFailed extends ManageCommissionState {
  final String msg;

  LoadDataFailed(this.msg);
}
class ReceivedData extends ManageCommissionState {
  final List<CommissionEntity> commissions;

  ReceivedData(this.commissions);
}
