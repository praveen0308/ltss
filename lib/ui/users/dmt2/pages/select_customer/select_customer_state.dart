part of 'select_customer_cubit.dart';

sealed class SelectCustomerState {}

class SelectCustomerInitial extends SelectCustomerState {}
class LoadingData extends SelectCustomerState {}
class ReceivedData extends SelectCustomerState {
  final List<UserEntity> data;

  ReceivedData(this.data);
}
class LoadDataFailed extends SelectCustomerState {
  final String msg;

  LoadDataFailed(this.msg);
}
