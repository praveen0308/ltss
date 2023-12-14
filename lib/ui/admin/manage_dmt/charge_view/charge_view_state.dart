part of 'charge_view_cubit.dart';

sealed class ChargeViewState {}

class ChargeViewInitial extends ChargeViewState {}
class Updating extends ChargeViewState {}
class UpdateFailed extends ChargeViewState {
  final String msg;

  UpdateFailed(this.msg);
}
class UpdateSuccessful extends ChargeViewState{
  final ChargeEntity newCharge;

  UpdateSuccessful(this.newCharge);
}