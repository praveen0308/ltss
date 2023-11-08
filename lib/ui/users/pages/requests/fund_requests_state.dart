part of 'fund_requests_cubit.dart';

sealed class FundRequestsState {}

class FundRequestsInitial extends FundRequestsState {}

class InitiatingUI extends FundRequestsState {}

class UILoaded extends FundRequestsState {
  final bool sentVisibility;
  final bool receivedVisibility;

  UILoaded(this.sentVisibility, this.receivedVisibility);
}
