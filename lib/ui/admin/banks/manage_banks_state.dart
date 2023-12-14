part of 'manage_banks_cubit.dart';

sealed class ManageBanksState {}

class ManageBanksInitial extends ManageBanksState {}
class LoadingData extends ManageBanksState {}
class ReceivedData extends ManageBanksState {
  final List<BankEntity> data;

  ReceivedData(this.data);
}
class LoadDataFailed extends ManageBanksState {
  final String msg;

  LoadDataFailed(this.msg);
}

class Deleting extends ManageBanksState {}
class DeletionSuccessful extends ManageBanksState {}
class DeletionFailed extends ManageBanksState {
  final String msg;

  DeletionFailed(this.msg);
}
