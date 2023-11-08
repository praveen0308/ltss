part of 'user_detail_cubit.dart';

sealed class UserDetailState {}

class UserDetailInitial extends UserDetailState {}

class LoadingData extends UserDetailState {}
class PerformingAction extends UserDetailState {}
class ActionSuccessful extends UserDetailState {
  final String msg;

  ActionSuccessful(this.msg);
}
class PerformActionFailed extends UserDetailState {
  final String msg;

  PerformActionFailed(this.msg);
}

class NoData extends UserDetailState {}

class OnDataLoaded extends UserDetailState {
  final UserDetailEntity data;
  final bool blockEnabled;
  final bool unblockEnabled;
  final bool editProfileEnabled;

  OnDataLoaded({
    required this.data,
    required this.blockEnabled,
    required this.unblockEnabled,
    required this.editProfileEnabled,

  });
}

class DataLoadFailed extends UserDetailState {
  final String msg;

  DataLoadFailed(this.msg);
}
