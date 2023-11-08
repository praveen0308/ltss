part of 'service_page_cubit.dart';

@immutable
abstract class ServicePageState {}

class ServicePageInitial extends ServicePageState {}
class LoadingData extends ServicePageState {}
class ReceivedData extends ServicePageState {
  final List<ServiceEntity> data;

  ReceivedData(this.data);
}
class LoadDataFailed extends ServicePageState {
  final String msg;

  LoadDataFailed(this.msg);
}

class Deleting extends ServicePageState {}
class DeletionSuccessful extends ServicePageState {}
class DeletionFailed extends ServicePageState {
  final String msg;

  DeletionFailed(this.msg);
}
