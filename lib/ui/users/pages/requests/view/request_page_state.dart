part of 'request_page_cubit.dart';

@immutable
sealed class RequestPageState {}

class RequestPageInitial extends RequestPageState {}

class LoadingData extends RequestPageState {}

class EmptyData extends RequestPageState {}

class OnDataLoaded extends RequestPageState {
  final List<FundRequestEntity> data;

  OnDataLoaded(this.data);
}

class DataLoadFailed extends RequestPageState {
  final String msg;

  DataLoadFailed(this.msg);
}
