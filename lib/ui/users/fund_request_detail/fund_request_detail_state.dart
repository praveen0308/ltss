part of 'fund_request_detail_cubit.dart';

enum FundRequestDetailStatus {
  initial,
  initializing,
  initializationSuccess,
  initializationFailed,
  loading,
  success,
  error,
  ;
}

extension FundRequestDetailStatusX on FundRequestDetailStatus {
  bool get isInitial => this == FundRequestDetailStatus.initial;

  bool get isInitializing => this == FundRequestDetailStatus.initializing;

  bool get isInitializationSuccessful =>
      this == FundRequestDetailStatus.initializationSuccess;

  bool get isInitializationFailed =>
      this == FundRequestDetailStatus.initializationFailed;

  bool get isSuccess => this == FundRequestDetailStatus.success;

  bool get isError => this == FundRequestDetailStatus.error;

  bool get isLoading => this == FundRequestDetailStatus.loading;
}

class FundRequestDetailState {
  const FundRequestDetailState({
    this.status = FundRequestDetailStatus.initial,
    this.msg,
    this.canAcceptReject = false,
    this.canRevoke = false,
    this.data

  });

  final FundRequestDetailStatus status;
  final String? msg;
  final bool canAcceptReject;
  final bool canRevoke;
  final FundRequestEntity? data;

  FundRequestDetailState copyWith({
    FundRequestDetailStatus? status,
    String? msg,
    bool? canAcceptReject,
    bool? canRevoke,
    FundRequestEntity? data,
  }) {
    return FundRequestDetailState(
      status: status ?? this.status,
      msg: msg ?? this.msg,
      canAcceptReject: canAcceptReject ?? this.canAcceptReject,
      canRevoke: canRevoke ?? this.canRevoke,
      data: data ?? this.data,
    );
  }
}
