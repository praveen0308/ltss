part of 'add_fund_request_cubit.dart';

sealed class AddFundRequestState {}

class AddFundRequestInitial extends AddFundRequestState {}
class LoadingDistributors extends AddFundRequestState {}
class DistributorsLoaded extends AddFundRequestState {
  final List<UserEntity> distributors;

  DistributorsLoaded(this.distributors);
}
class LoadDistributorsFailed extends AddFundRequestState {
  final String msg;

  LoadDistributorsFailed(this.msg);
}

class AddingRequest extends AddFundRequestState {}

class AddedSuccessfully extends AddFundRequestState {}

class AddFundRequestFailed extends AddFundRequestState {
  final String msg;

  AddFundRequestFailed(this.msg);
}
