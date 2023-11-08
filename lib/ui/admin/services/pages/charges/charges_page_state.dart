part of 'charges_page_cubit.dart';

@immutable
abstract class ChargesPageState {}

class ChargesPageInitial extends ChargesPageState {}

class LoadingData extends ChargesPageState {}
class ReceivedData extends ChargesPageState {
  final List<ChargeEntity> data;

  ReceivedData(this.data);
}
class LoadDataFailed extends ChargesPageState {
  final String msg;

  LoadDataFailed(this.msg);
}



class Deleting extends ChargesPageState {}
class DeletionSuccessful extends ChargesPageState {}
class DeletionFailed extends ChargesPageState {
  final String msg;

  DeletionFailed(this.msg);
}


