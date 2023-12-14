part of 'manage_charge_cubit.dart';

sealed class ManageChargeState {}

class ManageChargeInitial extends ManageChargeState {}
class LoadingData extends ManageChargeState {}
class LoadDataFailed extends ManageChargeState {
  final String msg;

  LoadDataFailed(this.msg);
}
class ReceivedData extends ManageChargeState {
  final List<ChargeEntity> charges;

  ReceivedData(this.charges);
}
