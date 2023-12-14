part of 'commission_view_cubit.dart';

sealed class CommissionViewState {}

class CommissionViewInitial extends CommissionViewState {}
class Updating extends CommissionViewState {}
class UpdateFailed extends CommissionViewState {
  final String msg;

  UpdateFailed(this.msg);
}
class UpdateSuccessful extends CommissionViewState{
  final CommissionEntity newCommission;

  UpdateSuccessful(this.newCommission);
}