part of 'commissions_page_cubit.dart';

@immutable
abstract class CommissionsPageState {}

class CommissionsPageInitial extends CommissionsPageState {}
class LoadingData extends CommissionsPageState {}
class ReceivedData extends CommissionsPageState {
  final List<CommissionEntity> data;

  ReceivedData(this.data);
}
class LoadDataFailed extends CommissionsPageState {
  final String msg;

  LoadDataFailed(this.msg);
}



class Deleting extends CommissionsPageState {}
class DeletionSuccessful extends CommissionsPageState {}
class DeletionFailed extends CommissionsPageState {
  final String msg;

  DeletionFailed(this.msg);
}
