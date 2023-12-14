part of 'search_customer_cubit.dart';

enum SearchCustomerStatus {
  initial,
  idle,
  customerDataLoaded,
  error;
}

extension SearchCustomerStatusX on SearchCustomerStatus {
  bool get isInitial => this == SearchCustomerStatus.initial;
  bool get isIdle => this == SearchCustomerStatus.idle;
  bool get isCustomerDataLoaded => this == SearchCustomerStatus.customerDataLoaded;

  bool get isError => this == SearchCustomerStatus.error;
}

class SearchCustomerState {
  SearchCustomerState({
    this.status = SearchCustomerStatus.initial,
    this.msg,
    this.canProceed = false,
    this.sender,
    this.beneficiaries,
  });

  final SearchCustomerStatus status;
  final String? msg;
  final bool canProceed;
  final DataStatus<Sender>? sender;
  final DataStatus<List<Beneficiary>>? beneficiaries;

  SearchCustomerState copyWith(
      {SearchCustomerStatus? status, String? msg,bool? canProceed,DataStatus<Sender>? sender,DataStatus<List<Beneficiary>>? beneficiaries}) {
    return SearchCustomerState(
      status: status ?? SearchCustomerStatus.idle,
      msg: msg ?? this.msg,
      canProceed: canProceed ?? this.canProceed,
      sender: sender ?? this.sender,
      beneficiaries: beneficiaries ?? this.beneficiaries,
    );
  }
}

sealed class DataStatus<T>{
  DataStatus._();
  factory DataStatus.empty() = Empty;
  factory DataStatus.loading() = Loading;
  factory DataStatus.data(T data) = Data;
  factory DataStatus.error(String msg) = Error;

}

class Empty<T> extends DataStatus<T>{
  Empty() : super._();
}
class Loading<T> extends DataStatus<T>{
  Loading() : super._();
}

class Data<T> extends DataStatus<T>{
  final T data;

  Data(this.data): super._();
}
class Error<T> extends DataStatus<T>{
  final String msg;

  Error(this.msg): super._();
}

