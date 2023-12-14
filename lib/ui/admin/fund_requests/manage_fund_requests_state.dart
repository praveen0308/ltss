part of 'manage_fund_requests_cubit.dart';

sealed class ManageFundRequestsState {}

class ManageFundRequestsInitial extends ManageFundRequestsState {}
class LoadingData extends ManageFundRequestsState {}
class EmptyData extends ManageFundRequestsState {}
class ReceivedData extends ManageFundRequestsState {
  final List<FundRequestEntity> newRequests;
  final List<FundRequestEntity> history;

  ReceivedData(this.newRequests, this.history);
}
class LoadDataFailed extends ManageFundRequestsState {
  final String msg;

  LoadDataFailed(this.msg);
}

class Updating extends ManageFundRequestsState {}
class UpdateSuccessful extends ManageFundRequestsState {}
class UpdateFailed extends ManageFundRequestsState {
  final String msg;

  UpdateFailed(this.msg);
}

