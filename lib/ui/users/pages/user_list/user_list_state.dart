part of 'user_list_cubit.dart';

sealed class UserListState {}

class UserListInitial extends UserListState {}

class LoadingData extends UserListState {}
class NoData extends UserListState {}

class OnDataLoaded extends UserListState {

  final List<UserEntity> users;

  OnDataLoaded(this.users);
}

class DataLoadFailed extends UserListState {
  final String msg;

  DataLoadFailed(this.msg);
}

